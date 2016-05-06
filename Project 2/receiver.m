function [est_Bits]=receiver(signal, noise)
% assert(size(signal,2)==size(noise,2))
nsamp = 6;
V =[];
filter_out=[];
out =[];
matched_s1 = ones(1,nsamp);
matched_s2 = -matched_s1;
for i=1:size(signal,1)
    V = [V; signal(i,:) + noise];
    filter_out = [filter_out; filter(matched_s1,1,V(i,:))-filter(matched_s2,1,V(i,:))];
    reshape_filter_out = reshape(filter_out(i,:),nsamp,[]);
    out = [out; mean(reshape_filter_out)];
end
Threshold = 0;
out(out>=Threshold) = 1;
out(out<Threshold) = 0;
est_Bits = out;

end