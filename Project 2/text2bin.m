function bn = text2bin(filename)
bn_length = 5;
fid = fopen(filename);
txt = fread(fid,'uint8=>char');
ascii = double(txt);
ascii(ascii==32) = 0; % ' ' to bn
ascii(ascii==44) = 1; % ',' to bn
ascii(ascii==46) = 2; % '.' to bn
ascii(ascii==39) = 3; % ''' to bn
ascii(ascii==10) = 4; % line feed to bn
ascii(ascii==13) = 5; % carriage return to bn
ascii(ascii >= 65 & ascii <= 90) = ascii(ascii >= 65 & ascii <= 90) + 32; % A-Z to a-z
ascii(ascii >= 97 & ascii <= 122) = ascii(ascii >= 97 & ascii <= 122) - 91; % a-z to bn
bn = dec2bin(ascii,bn_length);
end