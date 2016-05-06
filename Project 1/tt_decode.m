function [digits] = tt_decode(x)
%Enmao Diao
%Fall 2016
%% Initialization
digits = [];
Fs = 8000;
data_length = length(x);
low_frequency = [697 770 852 941];
high_frequency = [1209 1336 1477 1633];
%% HighPass Filter to filter out band below 697 Hz (dial tone)
[b,a] = cheby1(9,0.5,650/4000,'high');
x = filter (b,a,x);
%% Determine M (data length) and N (gfft length)
M = 100;
Max_N = 500; % largest N tolerated for computation
location_error_threshold = 0.015;
DFT_sample_separation_threshold = 2;
N_low_candidate = [];
N_high_candidate = [];
K_low_candidate = [];
K_high_candidate = [];
% find proper value for lower and higher band N based on 1.5% (find N that satisfies DFT sample location error for lower and higher band)
% and 3.5% (each DTMF tone has its unique DFT sample index K) specification
for n = M:Max_N % minimum N is M
    frequency_space_low = Fs/n;
    frequency_space_high = Fs/n;
    K_low = round(low_frequency./frequency_space_low);
    K_high = round(high_frequency./frequency_space_high);
    location_error_low = (K_low.*frequency_space_low - low_frequency)./low_frequency;
    location_error_high = (K_high.*frequency_space_high - high_frequency)./high_frequency;
    if(all(abs(location_error_low) <= location_error_threshold) && length(unique(K_low))==length(K_low) ...
            && all(diff(K_low)>=DFT_sample_separation_threshold))
        N_low_candidate = [N_low_candidate n];
        K_low_candidate = [K_low_candidate; K_low];
    end
    if(all(abs(location_error_high) <= location_error_threshold)&& length(unique(K_high))==length(K_high) ...
             && all(diff(K_high)>=DFT_sample_separation_threshold))
        N_high_candidate = [N_high_candidate n];
        K_high_candidate = [K_high_candidate; K_high];
    end
end

K_low = K_low_candidate(round(end/2),:);
N_low = N_low_candidate(round(end/2));
K_high = K_high_candidate(round(end/2),:);
N_high = N_high_candidate(round(end/2));

%% Windowing and GFFT
prev_frequency_low = 0;
prev_frequency_high = 0;
window_counter = 0;
digit_counter = 0;
min_tone_length = 80e-3;
window_length = M;
window_length_time = M/Fs;
window_per_tone = floor(min_tone_length/window_length_time);
digitcode = ['1' '2' '3' 'A'; '4' '5' '6' 'B'; '7' '8' '9' 'C'; '*' '0' '#' 'D']; % A model of dial pad.

for i = 1:window_length-1:data_length-window_length+1
    
    frequency_low_1 = abs(gfft(x(i:i+window_length-1),N_low,K_low(1)));
    frequency_low_2 = abs(gfft(x(i:i+window_length-1),N_low,K_low(2)));
    frequency_low_3 = abs(gfft(x(i:i+window_length-1),N_low,K_low(3)));
    frequency_low_4 = abs(gfft(x(i:i+window_length-1),N_low,K_low(4)));
    
    frequency_high_1 = abs(gfft(x(i:i+window_length-1),N_high,K_high(1)));
    frequency_high_2 = abs(gfft(x(i:i+window_length-1),N_high,K_high(2)));
    frequency_high_3 = abs(gfft(x(i:i+window_length-1),N_high,K_high(3)));
    frequency_high_4 = abs(gfft(x(i:i+window_length-1),N_high,K_high(4)));
    
    [low_value,frequency_low] = max([frequency_low_1 frequency_low_2 frequency_low_3 frequency_low_4]);
    [high_value,frequency_high] = max([frequency_high_1 frequency_high_2 frequency_high_3 frequency_high_4]);
    
    if(prev_frequency_low == frequency_low)&&(prev_frequency_high == frequency_high)
        window_counter = window_counter + 1;
        if (window_counter == window_per_tone) % we find a tone which has duration longer than threshold
            digits = [digits digitcode(frequency_low,frequency_high)];
            digit_counter = digit_counter + 1;
            if(digit_counter == 3 || digit_counter == 6) %add number template
                digits = [digits '-'];
            end
        end
    else
        window_counter = 0;
    end
    prev_frequency_low = frequency_low;
    prev_frequency_high = frequency_high;
end
end
