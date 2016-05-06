function demodBn = QPSK2bin(bs)
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
end