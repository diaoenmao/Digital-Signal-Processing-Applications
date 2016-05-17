function [txt_test, error_rate_QPSK, error_rate_txt]=evaluation(filename,QPSK_test,order_desired)
head_signal = 85; %[0:31 4 5 asciiseq(find(~isnan(asciiseq))) 0 0 0 0 0 0], [0:31 4 5] length is 34, 34*5/2 = 85
[QPSK_real, ascii] = file2bin(filename);
txt_real = char(ascii);
txt_test = bin2text(QPSK_test(head_signal+1-order_desired+1:end));
txt_test=txt_test(1:length(txt_real));

dot_idx = find(filename == '.');
outfilename = strcat(filename(1:dot_idx-1),'_out',filename(dot_idx:end));
fileID_out = fopen(outfilename,'w');
fwrite(fileID_out,txt_test,'uint8');
fclose(fileID_out);
[QPSK_test, ~] = file2bin(outfilename);

error_rate_QPSK = length(find(QPSK_real ~= QPSK_test))/length(QPSK_real);
error_rate_txt = length(find(txt_real ~= txt_test))/length(txt_real);
display(sprintf('Error rate is %f%% over %d QPSK symbols',error_rate_QPSK*100,length(QPSK_real)));
display(sprintf('Error rate is %f%% over %d text',error_rate_txt*100,length(txt_real)));
end