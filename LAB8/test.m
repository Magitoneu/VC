clear all
I = rgb2gray(imread('Chess figures.png'));

BW = I < 128;
BW = imclose(BW, strel('disk', 1));
BW = imrotate(BW,30);
BW = imopen(BW, strel('disk',10));

cc = bwconncomp(BW);
lab = bwlabel(BW);

[B, L, N] = bwboundaries(BW);
cc = bwconncomp(BW);
obs = regionprops(cc, 'Area');
Area = cell2mat(struct2cell(obs))';
obs1 = regionprops(cc, 'Extent', 'Eccentricity', 'Solidity', ...
        'Orientation');
O1 = cell2mat(struct2cell(obs1))';
obs2 = regionprops(cc, 'MajorAxisLength', 'MinorAxisLength');
O2 = cell2mat(struct2cell(obs2))';
O2(:, 1) = O2(:,1).^2 ./ Area;
O2(:, 2) = O2(:,2).^2 ./ Area;
obs3 = regionprops(cc, 'Area', 'Perimeter');
O3 = cell2mat(struct2cell(obs3))';
O3(:, 1) = (O3(:,2)) ./ O3(:,1);
O3(:, 2) = [];

for i = 1:length(B)
    boundary = B{i};
    [dist, angle] = signature(boundary);
    sumes(i) = sum(dist)/length(dist);
    NumMaxims(i) = length(findpeaks(dist));
    Maxims(i) = max(dist);
    DiffMinMax(i) = max(dist) - min(dist);
end
S = sumes'.^2./Area;
NM = NumMaxims'.^2;
D = DiffMinMax'.^2./Maxims';
M = Maxims'.^2./Area;

O22 = [S NM D M O1 O2 O3];

