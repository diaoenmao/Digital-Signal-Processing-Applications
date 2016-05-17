function [digits] = tt_decode(x)
digits = [];
out = [];
digit = [];
M= 106;
Nl = 334;
Nh = 191;

k1 = 29;
k2 = 33;
k3 = 36;
k4 = 40;

k5 = 29;
k6 = 32;
k7 = 36;
k8 = 39;

leng = length(x);
xref = x(1:M);
newstate = 0;
oldstate = newstate;

oldpos1 = 1;
newpos1 = 1;


oldpos2 = 1;
newpos2 = 1;

poscounter = 0;

digitcode = [1 2 3 11 4 5 6 12 7 8 9 13 14 0];
for i = M+1:M-1:leng-M+1
    XF9 = abs(gfft(x(i:i+M-1),Nl,31));
    XF10 = abs(gfft(x(i:i+M-1),Nh,30));
    
    XF1 = abs(gfft(x(i:i+M-1),Nl,k1));
    XF2 = abs(gfft(x(i:i+M-1),Nl,k2));
    XF3 = abs(gfft(x(i:i+M-1),Nl,k3));
    XF4 = abs(gfft(x(i:i+M-1),Nl,k4));
    
    XF5 = abs(gfft(x(i:i+M-1),Nh,k5));
    XF6 = abs(gfft(x(i:i+M-1),Nh,k6));
    XF7 = abs(gfft(x(i:i+M-1),Nh,k7));
    XF8 = abs(gfft(x(i:i+M-1),Nh,k8));
    avg1 = (XF1+XF2+XF3+XF4)/4;
    avg2 = (+XF5+XF6+XF7+XF8)/4;
    [val1,pos1] = max([XF1 XF2 XF3 XF4]);
    [val2,pos2] = max([XF5 XF6 XF7 XF8]);
    
    newpos1 = pos1;
    newpos2 = pos2;
    if (oldpos1 == newpos1)&&(oldpos2 == newpos2)
        oldpos1 = newpos1;
        oldpos2 = newpos2;
        poscounter = poscounter + 1;
        if (poscounter == 5)
            digits = [digits digitcode((pos1-1)*4+pos2)];
        end
    else
        oldpos1 = newpos1;
        oldpos2 = newpos2;
        poscounter = 0;
    end

%     if ((val1 > sum([XF1 XF2 XF3 XF4]) - val1 +avg1) && (val2 > sum([XF5 XF6 XF7 XF8]) - val2 +avg2))
%         newstate = 1;
%     else
%         newstate = 0;
%     end
    
%     out = [out;XF1,XF2,XF3,XF4,XF5,XF6,XF7,XF8,avg1,avg2,XF9,XF10];
%     digits = [digits;20*log10(XF1/val1),20*log10(XF2/val1),20*log10(XF3/val1),20*log10(XF4/val1),20*log10(XF5/val2),20*log(XF6/val2),20*log10(XF7/val2),20*log10(XF8/val2),20*log10(avg1/val1),20*log10(avg2/val2)];
%     digit = [digit;20*log10(abs(XF1-XF9)/val1),20*log10(abs(XF2-XF9)/val1),20*log10(abs(XF3-XF9)/val1),20*log10(abs(XF4-XF9)/val1),20*log10(abs(XF5-XF10)/val2),20*log(abs(XF6-XF10)/val2),20*log10(abs(XF7-XF10)/val2),20*log10(abs(XF8-XF10)/val2),20*log10(abs(avg1-XF9)/val1),20*log10(abs(avg2-XF10)/val2)];
%     
end
    digits = int2str(digits);
    digits(digits==' ') = [];
end

