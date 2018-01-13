function [ O ] = getObs( I )

[rows,cols] = size(I);
Hist =  imhist(I);
Hist = Hist/trapz(1:256,Hist);
Hist(Hist(:) < 0.0015) = 0;
features = extractHOGFeatures(I);
O = [features];
end

