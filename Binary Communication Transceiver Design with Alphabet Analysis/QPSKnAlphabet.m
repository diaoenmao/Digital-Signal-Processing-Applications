function Qtext = QPSKnAlphabet(filename, QPSKSymbols,letter)
if(~isempty(filename))
    bn = text2bin(filename);
    Sn = bin2QPSK(bn);
    demodBn = QPSK2bin(Sn);
    T = bin2text(demodBn);
elseif(~isempty(QPSKSymbols))
    filename = 'QPSK.txt';
    demodBn= QPSK2bin(QPSKSymbols);
    T = bin2text(demodBn);
else
    display('not enough inputs')
end
dec = bin2dec(demodBn);
dec = dec';
dec = dec(dec >= 6 & dec <= 31); % only letters;
mean_dec = mean(dec);
std_dec = std(dec);
if(~isempty(letter))
    if(letter>=65 && letter <= 90)
        letter = letter + 32;
    end
    if(letter >= 97 && letter <= 122)
        letter = letter - 91;
    end
    letfreq = length(dec(dec == letter))/length(dec) * 100;
else
    letfreq = [];
end
dot_idx = find(filename == '.');
outfilename = strcat(filename(1:dot_idx-1),'_out',filename(dot_idx:end));
fileID = fopen(outfilename,'w');
fwrite(fileID,T,'uint8')
if(~isempty(filename))
    bn_out = text2bin(outfilename);    
    error_rate = sum(any(bn_out ~= bn,2))/size(bn,1);
    display(sprintf('Error rate: %d %%',error_rate));
end

Qtext = struct('mean',mean_dec,'std',std_dec,'outtext',T,'oneLetfreq',strcat(num2str(letfreq), ' %'));  
end