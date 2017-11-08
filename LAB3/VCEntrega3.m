
%%Exercici 1



%% Exercici 2
I = imread('lenna.tif');
Isp = double(imnoise(I,'salt & pepper', 0.01));

If = colfilt(Isp,[3 3], 'sliding', @(x) colFunc(x));
figure(1), imshow(If, []),title('Filtered');
figure(2), imshow(Isp, []),title('Added salt & pepper noise');

clear all
%%Exercici 3

I = double(imread('lenna.tif'));
kernel = [0 -1 0; -1  5 -1; 0 -1 0];
If = imfilter(I,kernel);
subplot(1,2,1),imshow(If,[]),title('Realzat');
subplot(1,2,2),imshow(I,[]),title('Normal');

%%Exercici 4

I = double(imread('lenna.tif'));

If = motionBlur(I,30);
figure,imshow(If, []),title('Blurred, 30 degrees');




%%Exercici 5


%If = recoverBlur(If);
%imshow(If,[]);

