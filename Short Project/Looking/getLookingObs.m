function [ obs ] = getLookingObs( I )

%Calculant distancies entre el llagrimal i el mig de iris seria bona

I = histeq(I);
Laplacian = [-1 -1 -1;-1 8 -1; -1 -1 -1];
Ilp = imfilter(I,Laplacian);

Hist =  imhist(Ilp);
Hist = Hist/trapz(1:256,Hist);
Hist(Hist(:) < 0.0015) = 0;
hog = extractHOGFeatures(Ilp);
obs = [hog];

end

