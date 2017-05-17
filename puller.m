Fs = 8000;
req = input('type:');
wordOne = words(1:40000,1:1);
wordTwo = words(1:40000,2:2);
wordThree = words(1:40000,3:3);
wordFour = words(1:40000,4:4);
if isequal(req,1)
    sampleOne = myRecording(wordOne(1):max(wordOne),1:1);
    sampleTwo = myRecording(wordTwo(1):max(wordTwo),1:1);
    sampleThree = myRecording(wordThree(1):max(wordThree),1:1);
    sampleFour = myRecording(wordFour(1):max(wordFour),1:1);
else
    testOne = myRecording(wordOne(1):max(wordOne),1:1);
    testTwo = myRecording(wordTwo(1):max(wordTwo),1:1);
    testThree = myRecording(wordThree(1):max(wordThree),1:1);
    testFour = myRecording(wordFour(1):max(wordFour),1:1);
end
% o = audioplayer(sampleOne,Fs);
% t = audioplayer(sampleTwo, Fs);
% th = audioplayer(sampleThree, Fs);
% f = audioplayer(sampleFour, Fs);
clear wordOne wordTwo wordThree wordFour Maxim Minim col_c counter datSize invar local_c w_c switcher strung sequence rel;