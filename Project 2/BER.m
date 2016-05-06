function out = BER(estimate, original)
% assert(size(estimate,2)==size(original,2))
compare=[];
for i=1:size(estimate,1)
    compare = [compare; estimate(i,:) - original];
end
out = sum(compare~=0,2)./length(estimate);
end