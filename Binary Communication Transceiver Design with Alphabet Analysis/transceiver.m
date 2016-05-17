function [ber]= transceiver(L, SNR)
%% Signal and Noise generation
Bits = DataGeneration(L);
bit_signal = Pulse(Bits, SNR);
noise = NoiseGeneration(L);
%% Estimation
est_Bits = receiver(bit_signal, noise);
ber = BER(est_Bits, Bits);
end