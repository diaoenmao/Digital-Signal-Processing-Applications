function message = lms_decode(x)
V = x;
load desired
% [~,~,error,snr] = lms_filter(x,2,d);
% L = 2;
% E = error;
% SNR_QPSK = snr;
% for i = 3:40;
%     [~,~,error,snr] = lms_filter(x,i,d);
%     E = [E error];
%     SNR_QPSK = [SNR_QPSK,snr];
% end
% [min_E,order_desired_E] = min(E);
% [max_SNR,order_desired_SNR] = max(SNR_QPSK);
order_desired = 6;
% [QPSK_E,h_E,~,~] = lms_filter(V,order_desired_E,d);
% [QPSK_SNR,h_SNR,~,~] = lms_filter(V,order_desired_SNR,d);
[QPSK,h,~,~] = lms_filter(V,order_desired,d);
figure
bar(0:order_desired-1,real(h)); axis([0 order_desired-1,-2/order_desired,2/order_desired]); title(sprintf('Real part h, L=%i',order_desired))
xlabel('m'), ylabel('h[m]')
figure
bar(0:order_desired-1,imag(h)); axis([0 order_desired-1,-2/order_desired,2/order_desired]); title(sprintf('Imaginary part h, L=%i',order_desired))
xlabel('m'), ylabel('h[m]')
figure
H = abs(fftshift(fft(h,256)));
f = [1:256]/256-0.5;
plot(f,H);title(sprintf('L=%i',order_desired))
xlabel('\itf'),ylabel('|H(\itf\it)|')

figure
scatter(real(V),imag(V),'.')
xlim([-2.5,2.5])
ylim([-2.5,2.5])
title('Signal with white noise')
xlabel('real')
ylabel('imaginary')
% figure
% scatter(real(QPSK_E),imag(QPSK_E),'.');
% title('output from final h E');
% xlabel('real')
% ylabel('imaginary')
% figure
% scatter(real(QPSK_SNR),imag(QPSK_SNR),'.');
% title('output from final h SNR');
% xlabel('real')
% ylabel('imaginary')
figure
scatter(real(QPSK),imag(QPSK),'.');
xlim([-2.5,2.5])
ylim([-2.5,2.5])
title('output from final h manual');
xlabel('real')
ylabel('imaginary')

filename = 'gettysburg.txt';
% display(sprintf('output from final h_E choose order %i',order_desired_E))
% [txt_test_E, error_rate_QPSK_E, error_rate_txt_E] = evaluation(filename,QPSK_E,order_desired_E);
% display(sprintf('output from final h_SNR choose order %i',order_desired_SNR))
% [txt_test_SNR, error_rate_QPSK_SNR, error_rate_txt_SNR] = evaluation(filename,QPSK_SNR,order_desired_SNR);
display(sprintf('output from final h manually choose order %i',order_desired))
[txt_test, error_rate, error_rate] = evaluation(filename,QPSK,order_desired);
message = txt_test;
end 