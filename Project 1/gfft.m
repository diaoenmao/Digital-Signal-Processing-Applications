% Function to Compute a DFT Sample
% Using Goertzel's Algorithm
% XF = gfft(x,N,k)
% x is the input sequence of length <= N
% N is the DFT length
% k is the specified bin number
% XF is the desired DFT sample
%
function XF = gfft(x,N,k)
if length(x) < N
   xe = [x zeros(1,N-length(x))];
else
   xe = x;
end
x1 = [xe 0];
d1 = 2*cos(2*pi*k/N);W = exp(-i*2*pi*k/N);
y = filter(1,[1 -d1 1],x1);
XF = y(N+1) - W*y(N);