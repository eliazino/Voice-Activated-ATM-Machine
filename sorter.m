load('myRecording.mat');
Minim = min(myRecording);
Maxim = max(myRecording);
%disp([Minim, Maxim]);
counter = 1;
datSize = size(myRecording);
datSize = datSize(1);
Passes = zeros(datSize,4);
v_pass = 1;
found_stat = 1;
while counter < datSize
    invar = myrecording(counter);
    if(invar >= 0)
        rel = (invar/Maxim)*100;
    else
        rel =(invar/Minim)*100;
    end
    if (isequal(found_stat,1))
        if (rel >= 20)
            Passes(found_stat,v_pass) = invar;
            found_stat = found_stat + 1;
        else
            
        end
    else
        if (rel >= 20)
            Passes(found_stat,v_pass) = invar;
            found_stat = found_stat + 1;
        else
           if (isequal())
        end
    end
end