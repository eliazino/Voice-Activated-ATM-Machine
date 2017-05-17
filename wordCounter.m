%strN = input('string is','s');
%load(strN);
Minim = min(myRecording);
Maxim = max(myRecording);
switcher = 0;
datSize = size(myRecording);
datSize = datSize(1);
silence = 0;
counter = 1;
strung = 0;
words = zeros(40000,4);
w_c = 0;
local_c = 1;
sequence = ones(1,12);
col_c = 1;
while counter < datSize
    invar = myRecording(counter);
    if(invar >= 0)
        rel = (invar/Maxim)*100;
    else
        rel =(invar/Minim)*100;
    end    
    if (rel < 20)
        strung = strung + 1;
        if (isequal(switcher,0) && (strung >= 2900))
            silence = silence + 1;
            switcher = 1;
        else
        end
    else        
        strung = 0;
        if (isequal(switcher,1))
            switcher = 0;  
            w_c = w_c + 1;
            local_c = 1;          
            words(local_c,w_c) = counter;                        
        else
            words(local_c,w_c) = counter;
            local_c = local_c + 1;
        end
    end
    counter = counter + 1;
end
disp(silence);