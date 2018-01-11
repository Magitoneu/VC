function [ O ] = getObs( I )

[rows,cols] = size(I);
Hist =  imhist(I);
Hist = Hist/sum(Hist);
Hist(Hist(:) < 0.0017) = 0;
features = extractHOGFeatures(I);
O = [features Hist'];
end

