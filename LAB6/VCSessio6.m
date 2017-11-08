
%%Morfologia

I = imread('Wheel.bmp');
Ig = rgb2gray(I);
BW = Ig > 20;

%BW = imfill(BW,'holes'); %Nomes es veuen les dents

SE = strel('disk',8);
EI = imerode(BW,SE);
OI = imopen(BW,SE);
CI = imclose(BW,SE);
DI = imdilate(BW,SE);

figure(1);
subplot(2,2,1), imshow(EI),title('Erosion');
subplot(2,2,2), imshow(OI),title('Open');
subplot(2,2,3), imshow(CI),title('Close');
subplot(2,2,4), imshow(DI),title('Dilated');


EIC = BW * 255 - EI * 64;
OIC = BW * 255 - OI * 64;
CIC = BW * 255 - CI * 64;
DIC = BW * 255 - DI * 64;

figure(2);
subplot(2,2,1), imshow(EIC,[]),title('Erosion');
subplot(2,2,2), imshow(OIC,[]),title('Open');
subplot(2,2,3), imshow(CIC,[]),title('Close');
subplot(2,2,4), imshow(DIC,[]),title('Dilated');


%BM = bwmorph(BW, 'remove'); 
%BM = bwmorph(BW, 'skel');
%BM = bwmorph(BW, 'shrink');
%figure(3),imshow(BM,[]);





%% Ex2
clear all
I = imread('cafe.tif');
BW = I < 16; %Cal separar objectes connectats debilment
SE = strel('disk',9);
EI = imerode(BW,SE);
figure(1), imshow(EI,[]);

DT = bwdist(1-BW, 'euclidean');
figure(2), imshow(DT,[]);

BDT = DT > 8.5;
figure(3), imshow(BDT,[]);








