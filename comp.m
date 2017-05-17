minT = min(testOne);
maxT = max(testOne);
minS = min(sampleOne);
maxS = max(sampleOne);
fZ = [minT/minS maxT/maxS];
[i j] = size(testOne);
counter = 1;
while counter < i
    NowC = testOne(counter);
    if NowC >= 0
        testOne(counter) = NowC * fZ(2);
    else
        testOne(counter) = NowC * fZ(1);
    end
    counter = counter + 1;
end