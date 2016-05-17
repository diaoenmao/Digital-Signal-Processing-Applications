function x=genChannel(s,filt,noise,SNRdB)
% FUNCTION x = genChannel(s,filt,noise,SNRdB)
% s = QPSK-encoded clean sequence
% SNRdB = desired SNR in dB
% if filt = 0, no dispersion is applied
% if filt = 1, time-invariant dispersion is added
% if filt = 2 or any other value, time-varying dispersion is added
% if noise = 1, noise is added

% This function applies channel dispersion and adds noise
x=channel(s,filt,noise,SNRdB);