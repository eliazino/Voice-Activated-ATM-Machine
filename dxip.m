function [ sample, test ] = dxip(i)
%sampleOne; sampleTwo; sampleThree; sampleFour;
%testOne; testTwo; testThree; testFour;
%DXIP Summary of this function goes here
%   Detailed explanation goes here
switch i
    case 1
        sample = sampleOne;
        test = testOne;
    case 2
        sample = sampleTwo;
        test = testTwo;
    case 3
        sample = sampleThree;
        test = testThree;
    case 4
        sample = sampleFour;
        test = testFour;
end

end

