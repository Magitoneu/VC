I = imread('money.tif');
h = imhist(I);
plot(h);

BW1 = I > 60;
BW2 = I > 120;


subplot(2,2,1),imshow(I),title('original');
subplot(2,2,2),imshow(BW1),title('bw1');
subplot(2,2,3),imshow(BW2),title('bw2');

clear all


%%Binaritzat amb color
I = imread('Enters manuscrits 1.jpg');
HSV = rgb2hsv(I);

figure;
subplot(2,2,1),imshow(I),title('original');

%Primer metode
If = (190/360 < HSV(:,:,1) & HSV(:,:,1) < 260/360) & (5/100 < HSV(:,:,2) & HSV(:,:,2) < 50/100) &(30/100 < HSV(:,:,3) & HSV(:,:,3) < 48/100);
subplot(2,2,2),imshow(If),title('midnight');

%Segon metode
H = HSV(:,:,1);
S = HSV(:,:,2);
V = HSV(:,:,3);
D = (230/360 - H).^2 + (50/100-S).^2+(22/100-V).^2;
BW = D < 0.25;
subplot(2,2,3),imshow(BW),title('midnight2');


%%Binaritzacio de gradients
clear all

I = imread('coins.png');
BWS = edge(I,'sobel');
BWC = edge(I,'canny');
figure;
subplot(2,2,1),imshow(I),title('Sobel');
subplot(2,2,2),imshow(BWS),title('Sobel');
subplot(2,2,3),imshow(BWC),title('Canny');


%%Binaritzacio de gradients mitjançant filtre de suavitzat
clear all

I = imread('coins.png');
IGauss = imfilter(I,fspecial('gaussian',[5 5],2));
IDiff = I - IGauss;
Diff = IDiff > 10;
figure, imshow(Diff);





