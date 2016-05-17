bn_length = 5;
fid = fopen('testFile.txt');
txt = fread(fid,'uint8=>char');
ascii = double(txt);
ascii(ascii==32) = [];
ascii(ascii==44) = [];
ascii(ascii==46) = [];
ascii(ascii==39) = [];
ascii(ascii==10) = [];
ascii(ascii==13) = [];
ascii(ascii >= 65 & ascii <= 90) = ascii(ascii >= 65 & ascii <= 90) + 32; % A-Z to a-z
%ascii(ascii >= 97 & ascii <= 122) = ascii(ascii >= 97 & ascii <= 122) - 91; % a-z

numberOfBins = 26;
[counts, binValues] = hist(ascii, numberOfBins);
subplot(2,1,1);
bar(binValues, counts, 'barwidth', 1);
xlabel('ASCII Value');
ylabel('Absolute Count');
title('Histogram of letters in testFile')
normalizedCounts = 100 * counts / sum(counts);
subplot(2,1,2);
bar(binValues, normalizedCounts, 'barwidth', 1);
xlabel('ASCII Value');
ylabel('Normalized Count(%)');
title('Normalized Histogram of letter frequncies in testFile')
