

I = imread('normal-blood1.jpg');
BW = rgb2gray(I);
BW = BW < 210;
BW = imfill(BW,'holes');
SE = strel('disk',1);
BW = imerode(BW,SE);
%Eliminacio de les celules que toquen les bores
BWEDGE = false(size(BW));
BWEDGE(1,:) = true;
BWEDGE(:,1) = true;
BWEDGE(end,:) = true;
BWEDGE(:,end) = true;
BWR = imreconstruct(BWEDGE, BW);
BW = BW - BWR;
BWR(1,3:end) = true;
BWR(:,1) = true;
BWR(:,end) = true;
BWR(end,:) = true;
BWR = imfill(BWR,'holes');
BWR(1,3:end) = false;
BWR(:,1) = false;
BWR(:,end) = false;
BWR(end,:) = false;

AllCells = BW + BWR;
DT = bwdist(AllCells, 'euclidean');
BDT = DT > 9;
imshow(BDT,[]);
figure, imshow(I);


