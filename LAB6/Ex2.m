

I = imread('normal-blood1.jpg');
BW = rgb2gray(I);
BW = BW < 210;
BW = imfill(BW,'holes');
imshow(BW);
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


%Distance Transformation
DT = bwdist(1-BW, 'euclidean');
figure(3), imshow(DT,[]);

BDT = DT > 28.5;
figure(4), imshow(BDT,[]); 

s = regionprops(BDT, 'centroid');
centroids = cat(1,s.Centroid);

%Distance Transformation EDGES
DTEDGE = bwdist(1-BWR, 'euclidean');
BDTEDGE = DTEDGE > 19;

sEDGE = regionprops(BDTEDGE, 'centroid');
centroidsEDGE = cat(1,sEDGE.Centroid);

%% EX3

AllCentroids = [centroids; centroidsEDGE];






%Imatge amb les celules marcades
figure(5),
imshow(I,[]);
hold on;
plot(centroids(:,1), centroids(:,2), 'b*')
plot(centroidsEDGE(:,1), centroidsEDGE(:,2),'b*')
hold off;

NumeroCeles = numel(s) + numel(sEDGE);










