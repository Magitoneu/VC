%EX2
clc, clear all
I = imread('onion.png');
%figure(1), imshow(I), title('Original');
HSV = rgb2hsv(I);
H = HSV(:,:,1);
S = HSV(:,:,2);
V = HSV(:,:,3);
O = [H(:), S(:), V(:)];
c = kmeans(O,4); 
IC = reshape(c,size(H));
figure(2),imshow(IC, []), title('K-Means');

%%Binaritzar la imatge 4 vagades (4 colors de kmeans)

Binaries(:,:,1) = IC == 1;
Binaries(:,:,2) = IC == 2;
Binaries(:,:,3) = IC == 3;
Binaries(:,:,4) = IC == 4;

C1 = bwconncomp(Binaries(:,:,1));
C2 = bwconncomp(Binaries(:,:,2));
C3 = bwconncomp(Binaries(:,:,3));
C4 = bwconncomp(Binaries(:,:,4));

npixels = cellfun(@numel, C1.PixelIdxList); 
[v1 pos1] = max(npixels);

npixels = cellfun(@numel, C2.PixelIdxList); 
[v2 pos2] = max(npixels);

npixels = cellfun(@numel, C3.PixelIdxList); 
[v3 pos3] = max(npixels);

npixels = cellfun(@numel, C4.PixelIdxList); 
[v4 pos4] = max(npixels);

[v p] = max([v1 v2 v3 v4]);
Cs = [C1 C2 C3 C4];
positions = [pos1 pos2 pos3 pos4];

Im = zeros(size(I(:,:,1)));
Im(Cs(p).PixelIdxList{positions(p)}) = 1; 

figure(3),subplot(2,2,1),imshow(Binaries(:,:,1)),title('Bin 1');
subplot(2,2,2),imshow(Binaries(:,:,2)),title('Bin 2');
subplot(2,2,3),imshow(Binaries(:,:,3)),title('Bin 3');
subplot(2,2,4),imshow(Binaries(:,:,4)),title('Bin 4');

If(:,:,1) = uint8(Im) .* I(:,:,1);
If(:,:,2) = uint8(Im) .* I(:,:,2);
If(:,:,3) = uint8(Im) .* I(:,:,3);
figure(4),imshow(If, []), title('Regio Més Gran Conexa Mostrada');



