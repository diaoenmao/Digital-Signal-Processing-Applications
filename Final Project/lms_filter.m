function[QPSK,h,MSE,SNR_QPSK] = lms_filter(V,L,d)
N = length(V);
n = randn(length(V),1)+j*randn(length(V),1);n = n/sqrt(var(n));
SNRdB = snr(V,n);
SNR = 10^(SNRdB/10);
S = sqrt(2*SNR);
mu_max = 1/L/(S^2/2);
mu = mu_max/100;
h = zeros(L,1);
% h = 2*(rand(L,1)-0.5)*(2/L);
% E = [];

x_arr = [];% d is desired signal
d_arr =[];
x = V(1:length(d));
for i = 1: ceil(N/L)
    x_arr = [x_arr;x];
    d_arr = [d_arr;d];
end
MSE_arr = [];
iterations = 1000:1000:10000;
% iterations = length(V);
for N = iterations
    for k = L:N
        xk = x_arr(k:-1:k-L+1);
        output = (h')*xk;
        error = d_arr(k) - output;
%         mu_k = 0.5/(xk'*xk+0.001); 
%         h = h + mu_k*conj(error)*xk;
        h = h+mu*conj(error)*(xk);     
    end
self_test = conv(h',x);
E = d - self_test(L:end);
MSE = sum(abs(E).^2)/N;
MSE_arr = [MSE_arr MSE];
end
% plot(iterations,MSE_arr)
% title('MSE vs iterations')
% xlabel('iterations')
% ylabel('MSE')

QPSK = conv(h',V);
QPSK = QPSK(L:length(V));
SNR_QPSK = snr(QPSK,n(L:length(V)));
end 