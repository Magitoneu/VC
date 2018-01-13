function [ obs ] = getLookingObs( I )

Hist =  imhist(I);
Hist = Hist/trapz(1:256,Hist);
Hist(Hist(:) < 0.0015) = 0;
hog = extractHOGFeatures(I);
obs = [Hist' hog];

end

