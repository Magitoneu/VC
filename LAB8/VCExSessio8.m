I = rgb2gray(imread('Chess figures.png'));

BW = I < 128;
BW = imclose(BW, strel('disk', 1));
cc = bwconncomp(BW);
lab = bwlabel(BW);

% Independents de la mida
obs = regionprops(cc, 'Extent', 'Eccentricity', 'Solidity', ...
        'Orientation');
O = cell2mat(struct2cell(obs))';

% Perímetre / Area

obs3 = regionprops(cc, 'Area', 'Perimeter');
O3 = cell2mat(struct2cell(obs3))';
Area = O3(:,1);
O3(:, 1) = (O3(:,2)) ./ O3(:,1);
O3(:, 2) = [];

% Minor Axis / Major Axis

obs2 = regionprops(cc, 'MajorAxisLength', 'MinorAxisLength');
O2 = cell2mat(struct2cell(obs2))';
O2(:, 1) = O2(:,1).^2 ./ Area;
O2(:, 2) = O2(:,2).^2 ./ Area;

%Centroid

obs4 = regionprops(cc, 'Centroid');
O4 = cell2mat(struct2cell(obs4))';


%Transformacions 

BWClose = imclose(BW, strel('disk', 15));
imshow(BWClose);
ccOpen = bwconncomp(BWClose);


for i=1:size(cc.PixelIdxList,2)
    PixelDiff = size(ccOpen.PixelIdxList{i},1) - size(cc.PixelIdxList{i},1);
    BalancedDiff(i) = PixelDiff / size(cc.PixelIdxList{i},1) * 100;
end

%


clear O
S = (sumes'.^2)./Area;
M = (Maxims'.^2)./Area;
D = (DiffMinMax'.^2)./Area;
O = [S M D];

%O77 = [O; OO];

c = ['H', 'K', 'Q', 'B', 'R', 'P']';
predictor = TreeBagger(100, O, c);


res = 0;

for i = 1:1
   [~, scores] = predictor.predict(O);

    sc_sort = sort(scores, 2);
    maxims = sc_sort(:, 6);
    sc_sort(:, 6) = 0;
    suma_maxims = sum(maxims);
    suma_2ndMax = sum(max(sc_sort, [], 2));
    res = res + (suma_maxims - suma_2ndMax)/1;
end
