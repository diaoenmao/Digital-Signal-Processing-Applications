% IIR - Example                           [Marenco, A. L., Feb. 3, 2016]
% ECE 4271 - Spring 2016
% 
Fs=8000; % Sampling rate
M=200; % number of samples in the signal
n=0:M-1;
F1=350; % one tone at 350 Hz
F2=1000; % Second tone at 1000 Hz
x=cos(2*pi*F1.*n/Fs)+cos(2*pi*F2.*n/Fs);
[X,F]=freqz(x,1,1024,Fs);
figure(1)
plot(F,abs(X))
grid on
xlabel('Frequency - Hz')
title('Original two-tone signal: 350 and 1000 Hz')
Fc=500; % cut-off frequency at Fc=500 Hz - low pass filter
Wp=2*pi.*Fc./Fs; % please see pag. 281 in HINTS
[B,A]=cheby1(5,0.5,Wp/pi,'low'); % low pass filter with cut-off Freq. = 500 Hz
% To plot your frequency response:
[H,F]=freqz(B,A,1024,Fs); % Using N=1024.
figure(2)
plot(F,abs(H))
xlabel('Frequency - Hz')
title('Chebyshev filter - Fc=500 Hz')
grid on
% Filter the signal with the H filter:
y=filter(B,A,x);
% The filtered output: (must have only one tone!)
[Y,F]=freqz(y,1,1024,Fs);
figure(3)
plot(F,abs(Y))
xlabel('Frequency - Hz')
title('Filtered signal - one tone: 350 Hz')
grid on