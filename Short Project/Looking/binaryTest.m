


I = uint8(squeeze(eyesDB(5,:,:)));
figure, imshow(I);
I = histeq(I);
figure, imshow(I);
BW = I > 150;
figure, imshow(BW);


Laplacian = [-1 -1 -1;-1 8 -1; -1 -1 -1];

Ilp = imfilter(I,Laplacian);
figure, imshow(Ilp);
