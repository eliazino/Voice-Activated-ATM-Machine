function [ newSamp ] = craptor(oldMat)
%CRAPTOR Summary of this function goes here
%   Detailed explanation goes here
z = size(oldMat);
a = oldMat(1:z(1),1:1);
b = oldMat(1:z(1),2:2);
i = max(a);
j = max(b);
x = i/j;
b = b*x;
newSamp = [a b];
end

