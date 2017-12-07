function [ O ] = getObs( I )

[rows,cols] = size(I);
range = 0:255;
Hist = imhist(I);
Sumes = sum(I(:))/(rows * cols);
features = extractHOGFeatures(I);
O = [Hist' Sumes double(features)];
end

