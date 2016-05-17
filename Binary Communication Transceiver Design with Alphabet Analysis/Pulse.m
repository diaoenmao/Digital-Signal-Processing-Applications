function S=Pulse(Bits, SNR)
nsamp = 6;
signal = rectpulse(Bits,nsamp);
T = 0.25;
SNR_linear = 10.^(SNR./10);
N0_linear = 2;
A = sqrt(SNR_linear.*N0_linear./T);
S = A'*(signal-0.5).*2;
%X = 0:T:(length(Bits)-1)*T;
%plot(X,S)
end