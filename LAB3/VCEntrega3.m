I = imread('lenna.tif');
Isp = double(imnoise(I,'salt & pepper', 0.5));

If = colfilt(Isp,[3 3], 'sliding', @(x) colFunc(x));
figure(1), imshow(If, []);
figure(2), imshow(Isp, []);
If = colfilt(If,[3 3], 'sliding', @(x) colFunc(x));
figure(3), imshow(If, []);