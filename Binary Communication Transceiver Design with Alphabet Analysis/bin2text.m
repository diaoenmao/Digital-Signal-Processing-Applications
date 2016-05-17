function T = bin2text(bs)
ascii = bin2dec(bs);
ascii = ascii';
ascii(ascii >= 6 & ascii <= 31) = ascii(ascii >= 6 & ascii <= 31) + 91;% bn to a-z 
ascii(ascii == 0) = 32;% bn to ' '
ascii(ascii == 1) = 44;% bn to ','
ascii(ascii == 2) = 46;% bn to '.'
ascii(ascii == 3) = 39;% bn to '''
ascii(ascii == 4) = 10;% bn to line feed
ascii(ascii == 5) = 13;% bn to carriage return
T = char(ascii);
end
