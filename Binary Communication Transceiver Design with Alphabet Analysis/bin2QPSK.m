function Sn = bin2QPSK(bs)
bs = bs';
[r,c] = size(bs);
bs = reshape(bs,1,r*c);
% if(mod(length(bs),2)==1)
%     bs = [bs '0'];
% end
Sn = zeros(1,ceil(length(bs)/2));
for idx=1:length(bs)
    bit = str2num(bs(idx));
    p = (1i)^(mod(idx-1,2))*(-1)^bit;
    Sn(floor((idx-1)/2)+1) = Sn(floor((idx-1)/2)+1) + p;
end

end
