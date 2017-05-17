function [ vlee ] = fAlgo(sampleVar, testVar)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%initialize the general counter for the speech to one : first speech of
%four
%counter = 1;
%start the mother Routine.
% while counter <= 4
%     %determine the data sizes;
%     %uarr = dxip(counter);
%     if isequal(counter,1)
%         s = size(sampleOne);
%         st = size(testOne);
%         %asign the test and sample values
%         considerSample = sampleOne; 
%         considerTest = testOne;
%     elseif isequal(counter,2)
%         s = size(sampleTwo);
%         st = size(testTwo);
%         considerSample = sampleTwo; 
%         considerTest = testTwo;
%     elseif isequal(counter,3)
%         s = size(sampleThree);
%         st = size(testThree);
%         considerSample = sampleThree; 
%         considerTest = testThree;
%     elseif isequal(counter,4)
%         s = size(sampleFour);
%         st = size(testFour);
%         considerSample = sampleFour; 
%         considerTest = testFour;
%     end
s = size(sampleVar);
st = size(testVar);
considerSample = sampleVar; 
considerTest = testVar;
    %create the empty arrays for positive and negatives
    samplePos = zeros(s(1),1);
    sampleNeg = zeros(s(1),1);
    testPos = zeros(st(1),1);
    testNeg = zeros(st(1),1);
    %initialize the counter
    ss = 1; 
    spos = 1;
    sneg = 1;
    tpos = 1;
    tneg = 1;
    %start the subroutine that separate the values by direction : for
    %sample
    while ss <= s(1)
        i = considerSample(ss,1);
        if (i >= 0)
            samplePos(spos,1) = i;
            spos = spos + 1;
        else
            sampleNeg(sneg,1) = i;
            sneg = sneg + 1;
        end
        ss = ss + 1;
    end
    samplePos = samplePos(1:spos-1,1:1);
    sampleNeg = sampleNeg(1:sneg-1,1:1);
    ss = 1;
    %start the subroutine that separate the values by direction : for
    %test
    while ss <= st(1)
        i = considerTest(ss,1);
        if (i >= 0)
            testPos(tpos,1) = i;
            tpos = tpos + 1;
        else
            testNeg(tneg,1) = i;
            tneg = tneg + 1;
        end
        ss = ss + 1;
    end
    testPos = testPos(1:tpos-1,1:1);
    testNeg = testNeg(1:tneg-1,1:1);
    %considering positive arrays
    %determine the least size
    if length(testPos) > length(samplePos)
        v = length(samplePos);
    else
        v = length(testPos);
    end
    j = round(0.9*v);
    %create empty slot for withdrawn samples
    sampleWP = ones(j,2);
    %find index of MAx in positives
    Smax = ind2sub(samplePos,max(samplePos));
    Tmax = ind2sub(testPos, max(testPos));
    %with Smax now...
    ex = Smax - 1;
    ye = length(samplePos)-Smax;
    xPrime = ((ex/(ex + ye))*j);
    yPrime = ((ye/(ex + ye))*j);
    startIndex = Smax - xPrime;
    stopIndex = Smax + yPrime;
    exSize = stopIndex - startIndex +1;
    sampleWP = ones(exSize,2);
    sampleWP(1:exSize,1) = samplePos(startIndex:stopIndex,1);
    sampleWP = craptor(sampleWP);
    %with Tmax now...
    ex = Tmax - 1;
    ye = length(testPos)-Tmax;
    xPrime = ((ex/(ex + ye))*j);
    yPrime = ((ye/(ex + ye))*j);
    startIndex = Tmax - xPrime;
    stopIndex = Tmax + yPrime;
    exSize = stopIndex - startIndex +1;
    sampleWP(1:exSize,2) = testPos(startIndex:stopIndex,1);
    %initiate comparism procedure for the positives array
    start = 1;
    Pcom = 0;
    while start <= length(sampleWP)
        samplePart = sampleWP(start,1);
        testPart = sampleWP(start,2);
        if samplePart >= testPart
            n = samplePart-testPart;
            if isequal(n,0)
                Pcom =Pcom + 100;
            else
                Pcom = Pcom + (100-((n/samplePart)*100));
            end            
            %disp(samplePart);
        else
            n = -samplePart+testPart;
            if isequal(n,0)
                Pcom =Pcom + 100;
            else
                Pcom = Pcom + (100-((n/testPart)*100));
            end 
            %Pcom = Pcom + (100-((testPart-samplePart)/samplePart)*100);
            %disp(testPart);
        end
        start = start+1;
    end
    tPerc= (Pcom)/length(sampleWP);
    %end of positive arrays
    
    %considering Negative arrays
    %determine the least size
    if length(testNeg) > length(sampleNeg)
        v = length(sampleNeg);
    else
        v = length(testNeg);
    end
    j = round(0.9*v);
    %create empty slot for withdrawn samples
    sampleWP = ones(j,2);
    %find index of MAx in positives
    %redefine the magnitude of Negs
    sampleNeg = -sampleNeg;
    testNeg = - testNeg;
    Smax = ind2sub(sampleNeg,max(sampleNeg));
    Tmax = ind2sub(testNeg, max(testNeg));
    %with Smax now...
    ex = Smax - 1;
    ye = length(sampleNeg)-Smax;
    xPrime = ((ex/(ex + ye))*j);
    yPrime = ((ye/(ex + ye))*j);
    startIndex = Smax - xPrime;
    stopIndex = Smax + yPrime;
    exSize = stopIndex - startIndex +1;
    sampleWP = ones(exSize,2);
    sampleWP(1:exSize,1) = sampleNeg(startIndex:stopIndex,1);
    %with Tmax now...
    ex = Tmax - 1;
    ye = length(testNeg)-Tmax;
    xPrime = ((ex/(ex + ye))*j);
    yPrime = ((ye/(ex + ye))*j);
    startIndex = Tmax - xPrime;
    stopIndex = Tmax + yPrime;
    exSize = stopIndex - startIndex +1;
    sampleWP(1:exSize,2) = testNeg(startIndex:stopIndex,1);
    sampleWP = craptor(sampleWP);
    %initiate comparism procedure for the positives array
    start = 1;
    Pcom = 0;
    while start <= length(sampleWP)
        samplePart = sampleWP(start,1);
        testPart = sampleWP(start,2);
        if samplePart >= testPart
            n = samplePart-testPart;
            if isequal(n,0)
                Pcom =Pcom + 100;
            else
                Pcom = Pcom + (100-((n/samplePart)*100));
            end            
            %disp(samplePart);
        else
            n = -samplePart+testPart;
            if isequal(n,0)
                Pcom =Pcom + 100;
            else
                Pcom = Pcom + (100-((n/testPart)*100));
            end 
            %Pcom = Pcom + (100-((testPart-samplePart)/samplePart)*100);
            %disp(testPart);
        end
        start = start+1;
    end
    tlPerc= (Pcom)/length(sampleWP);
    %end of positive arrays
    vlee = (tlPerc+tPerc)/2;
%     if (vlee <= 40)
%         disp(['sorry, the word match was not found at ', int2str(vlee), '%']);
%         %break;
%     else
%         if isequal(counter,4)
%             disp(['The word was succesfully found',int2str(vlee), '%']);
%         else
%             disp(['Moving to the next word ', int2str(vlee),'% match ']);
%         end
%     end
%      counter = counter + 1;
% end
end

