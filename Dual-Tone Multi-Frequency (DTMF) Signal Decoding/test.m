result = [];
count = 0;
iteration = 1000;
for iter = 1:iteration
    for i=1:8
        [signal_bank, digits] = My_tt_create(10);
        result =tt_decode(signal_bank(i,:));
        if(~(strcmp(result,digits)))
            count=count+1;
            SNRdB = [50 40 30 20 15 10 5 0];
            display(sprintf('Error occured at %d dB:\nExpected %s\nResult %s\n', SNRdB(i), digits, result));
        end
    end
end
display(sprintf('Error rate: %f %%', count/(iteration*8)*100));