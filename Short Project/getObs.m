function [ O ] = getObs( I )

[rows,cols] = size(I);
Hist = imhist(I);
Sumes = sum(I(:))/(rows * cols);
features = extractHOGFeatures(I);
O = [Hist' double(features)];
end

