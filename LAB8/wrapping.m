I = imread('Queen.png');
t = affine2d([1.2 0.3 0; 0 1 0; 0 0 1]);
I = imwarp(I,t);
I = rgb2gray(I);

BW = I < 128;
BW = imclose(BW, strel('disk', 2));
BW = imclearborder(BW);
imshow(BW);

