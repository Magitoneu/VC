clc, clear all

%%Exercici 1 Punt de més alt contrast

I = imread('Bottle.bmp');
Iaux  = I(1:end,1)
I2 = I(1:end,1:end-1);
I2 = [Iaux I2];
Contrast = I - I2;
[v p] = max(Contrast); [v1 p1] = max(max(Contrast));
Contrast(p(p1), p1)
point = [p(p1) p1];
If = MidpointCircle(I, 10, point(1), point(2), 255);
figure(1),imshow(If), title('Most contrast point');

%%Exercici 2

x = length(I);
y = length(I(1,1:end));
res(255) = 0;
for i = 1:1:x
    for j = 1:1:y
        res(I(i,j)) = res(I(i,j)) + 1;
    end
end
figure(2),bar(res),title('My Histogram');
figure(3),imhist(I),title('Matlab histogram');

%%Exercici 3

Iresiced = imresize(I,3/7);
figure(4), imshow(Iresiced);
Iresiced = imresize(Iresiced,[477 474]);
figure(5), imshow(Iresiced);
PN = mean2(double(I));
Ps = std2((Iresiced-I));
SNR = 10*log10(Ps/PN)

%%Exercici 4

%C = imStitching(A B T);

