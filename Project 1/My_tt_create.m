function [signal_bank, digits_out] = My_tt_create(num_digits)
% Enmao Diao
% 2016

% tt_create.m
%
% M-file to create a row vector containing a sequence of
% touch tones, dial tone, and silence. Gaussian noise of 
% a specified SNR is included in all tones and silences.
%
% Written by Dr. Mark A. Richards
% January 2003

% Set up sampling frequency and time
Fs = 8e3;

% define vector of low band and high bnad frequencies in Hz,
% then convert to normalized frequencies in radians.  Ditto for dial tone.
f_low = [697 770 852 941]; f_high = [1209 1336 1477 1633];
w_low = f_low*2*pi/Fs; w_high = f_high*2*pi/Fs;

% Now input from the keyboard the touch tone sequence to be generated:
digits = round(9*rand(1,num_digits));
Num_digits=num_digits;

% Now generate the noise-free tone sequence.  Start with a 1 second dial tone.
% Then each digit will have a duration that varies uniformly between
% tt_short and tt_long; they will be separated by silences that vary
% between quite_short and quiet_long.

N_dt = 1.0*Fs;  %number of dial tone samples;
signal = sin(2*pi*350/Fs*(0:N_dt-1)) + sin(2*pi*440/Fs*(0:N_dt-1));
% sound(signal);

% Now concatenate each of the spaces and digits needed, randomly choosing
% lengths of each within the parameters specified.
% Finish with 1 second of silence.

tt_short = 80e-3; tt_long = 400e-3;
quiet_short = 50e-3; quiet_long = 200e-3;

for i=1:Num_digits
   quiet_length = round(((quiet_long-quiet_short)*rand(1,1) + quiet_short)*Fs);
   signal = [signal,zeros(1,quiet_length)]; % add quiet space
    
    switch digits(i)
        case 1
            w1=w_low(1); w2=w_high(1);
        case 2
            w1=w_low(1); w2=w_high(2);
        case 3
            w1=w_low(1); w2=w_high(3);
        case 4
            w1=w_low(2); w2=w_high(1);
        case 5
            w1=w_low(2); w2=w_high(2);
        case 6
            w1=w_low(2); w2=w_high(3);
        case 7
            w1=w_low(3); w2=w_high(1);
        case 8
            w1=w_low(3); w2=w_high(2);
        case 9
            w1=w_low(3); w2=w_high(3);
        case 0
            w1=w_low(4); w2=w_high(2);
        otherwise
            disp('Error: non-numeric touch tone input.')
    end
	tt_length = round(((tt_long-tt_short)*rand(1,1) + tt_short)*Fs);
    n=0:tt_length-1;
    tone = sin(w1*n) + sin(w2*n);
    signal = [signal,tone];
end

% add one more second of quiet at the end
signal = [signal,zeros(1,Fs)];

% Now for noise.  Power in a real sinusoid of amplitude A is A^2/2;
% for sum of 2 non-harmonic sinusoids we will consider it to be
% sum of their separate powers, so A^2.  In this M file, A=1, so
% power of each touch tone pair is assumed to be 1.0.
% Power of Gaussian noise is its variance, so we set variance to
% get desired SNR and add zero mean Gaussian noise.

SNRdB = [50 40 30 20 15 10 5 0]; % this is the input spec

SNR = 10.^(-SNRdB./10);
std_dev=sqrt(SNR);
signal_bank = [];

for i=1:length(SNRdB)
    noise_signal = [signal,zeros(1,Fs)];
    noise_signal = noise_signal + std_dev(i)*randn(size(noise_signal));
    noise_signal = noise_signal/max(abs(noise_signal));
    signal_bank = [signal_bank; noise_signal];
end

% Scale to maximum amplitude of 1
temp = num2str(digits);

temp(temp==' ') = [];
temp = strcat(temp(1:3),'-',temp(4:6),'-',temp(7:end));
digits_out = temp;

% Listen to the result
end