SNR = 0:2:16;
L = 10^6;
SNR_linear = 10.^(SNR./10);
BER = transceiver(L, SNR);
TheoryBER = qfunc(sqrt(2*SNR_linear));
semilogy(SNR,TheoryBER)
hold on
semilogy(SNR,BER)
legend('Theory BER','Matched Filter BER, nsample=4')
xlabel('SNR(dB)')
ylabel('BER')
title('BER vs SNR')