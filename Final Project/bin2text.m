function text = bin2text(bs)
bn_length = 5;
Threshold = 0;
bits = [];
for index = 1:length(bs)
    b1 = real(bs(index));
    b2 = imag(bs(index)); 
    if(b1 < -Threshold)
        b1 = '1';
    elseif(b1 > Threshold)
        b1 = '0';
    else
        display('threshold situation detected')
        b1 = '1';
    end
    
    if(b2 < -Threshold)
        b2 = '1';
    elseif(b2 > Threshold)
        b2 = '0';
    else
        b2 = '1';
        display('threshold situation detected')
    end
    bits = [bits b1 b2];
end
demodBn = reshape(bits, bn_length , length(bits)/bn_length);
demodBn = demodBn';
ascii = bin2dec(demodBn);
ascii = ascii';
ascii(ascii >= 6 & ascii <= 31) = ascii(ascii >= 6 & ascii <= 31) + 91;% bn to a-z 
ascii(ascii == 0) = 32;% bn to ' '
ascii(ascii == 1) = 44;% bn to ','
ascii(ascii == 2) = 46;% bn to '.'
ascii(ascii == 3) = 39;% bn to '''
ascii(ascii == 4) = 10;% bn to line feed
ascii(ascii == 5) = 13;% bn to carriage return
text = char(ascii);
end