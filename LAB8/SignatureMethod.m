clear all
I = rgb2gray(imread('Chess figures.png'));

BW = I < 128;
BW = imclose(BW, strel('disk', 1));
cc = bwconncomp(BW);
lab = bwlabel(BW);

[B, L, N] = bwboundaries(BW);
cc = bwconncomp(BW);
obs = regionprops(cc, 'Area');
Area = cell2mat(struct2cell(obs))';


for i = 1:length(B)
    boundary = B{i};
    [dist, angle] = signature(boundary);
    sumes(i) = sum(dist)/length(dist);
    NumMaxims(i) = length(findpeaks(dist));
    Maxims(i) = max(dist);
    DiffMinMax(i) = max(dist) - min(dist);
end
S = sumes'.^2./Area;
NM = NumMaxims';
D = DiffMinMax'./Maxims';
M = Maxims'./Area;

O = [S NM D M];

c = ['H', 'K', 'Q', 'B', 'R', 'P']';
predictor = TreeBagger(100, O, c);
