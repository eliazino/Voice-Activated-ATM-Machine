function [ vX vY ] = vpadd( vA, vB )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
xSize = length(vA);
ySize = length(vB);
x = find(vA == max(vA));
if numel(x) > 1
    minx = find(vA==min(vA));
%     dexMat = zeros(numel(x),numel(minx));
    decMat = zeros(numel(x),1);
    zStart = 1;
    while zStart <= numel(x)
%         dexMat(zStart:zStart,1:numel(minx)) = abs(x(zStart) - minx);
        s = abs(x(zStart) - minx);
        cf = find(s == min(s));
        if (numel(cf) > 1)
            decMat(zStart) = cf(1);
        else
            decMat(zStart) = cf;
        end
        zStart = zStart + 1;
    end
    xi = find(decMat == min(decMat));
    if numel(xi) > 1
        xi = xi(1);
    end
    x = x(xi);
end
xP = x - 1;
xPP = xSize - x;
y = find(vB == max(vB));
if numel(y) > 1
    minx = find(vB==min(vB));
%     dexMat = zeros(numel(x),numel(minx));
    decMat = zeros(numel(y),1);
    zStart = 1;
    while zStart <= numel(y)
%         dexMat(zStart:zStart,1:numel(minx)) = abs(x(zStart) - minx);
        s = abs(y(zStart) - minx);
        cf = find(s == min(s));
        if (numel(cf) > 1)
            decMat(zStart) = cf(1);
        else
            decMat(zStart) = cf;
        end
        zStart = zStart + 1;
    end
    yi = find(decMat == min(decMat));
    if numel(yi) > 1
        yi = yi(1);
    end
    y = y(yi);
end
yP = y-1;
yPP = ySize - y;
detX = 0;
detY = 0;
if xP > xPP
    detX = xPP;
else
    detX = xP;
end
if yP > yPP
    detY = yPP;
else
    detY = yP;
end
fetchEl = 0;
if detY > detX
    fetchEl = detX;
else
    fetchEl = detY;
end
vX = vA(abs(fetchEl-x):fetchEl+x);
vY = vB(abs(fetchEl-y):fetchEl+y);
end

