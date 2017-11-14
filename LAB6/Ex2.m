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


%Distance Transformation
DT = bwdist(1-BW, 'euclidean');
figure(1), imshow(DT,[]),title('Distance Transformation (no edges)');

BDT = DT > 28.5;
figure(2), imshow(BDT,[]), title('Binaritzacio de DT (no edges)')

s = regionprops(BDT, 'centroid');
centroids = cat(1,s.Centroid);

%Distance Transformation EDGES
DTEDGE = bwdist(1-BWR, 'euclidean');
figure(3), imshow(DTEDGE, []), title('Distance Transformation Edges');
BDTEDGE = DTEDGE > 19;
figure(4), imshow(BDTEDGE,[]), title('Binaritzacio de DT Edges');


sEDGE = regionprops(BDTEDGE, 'centroid');
centroidsEDGE = cat(1,sEDGE.Centroid);

allCentroids = [centroids; centroidsEDGE];
distances(:, :) = pdist2(allCentroids(:, :), allCentroids(:, :), 'euclidean');

distances(distances == 0) = Inf;
dVector = min(distances);
[~, p] = max(dVector);

I = insertMarker(I, allCentroids(p, :),'color','g', 'size', 20);


%Imatge amb les celules marcades
figure(5), imshow(I,[]), title('Cèl·lules marcades');
hold on;
plot(centroids(:,1), centroids(:,2), 'b*')
plot(centroidsEDGE(:,1), centroidsEDGE(:,2),'b*')
hold off;

NumeroCeles = numel(s) + numel(sEDGE);











