function [ O, dists, angles ] = get_Obs_One( I )

BW = I < 128;
BW = imclose(BW, strel('disk', 2));
BW = imclearborder(BW);
cc = bwconncomp(BW);
lab = bwlabel(BW);
BW = imfill(BW,'holes');
cc = bwconncomp(BW);
obs = regionprops(cc, 'Area');
Area = cell2mat(struct2cell(obs))';
%Observacions amb característiques de regionProps
obs1 = regionprops(cc, 'Extent', 'Eccentricity', 'Solidity');
O1 = cell2mat(struct2cell(obs1))';
obs2 = regionprops(cc, 'MajorAxisLength', 'MinorAxisLength');
O2 = cell2mat(struct2cell(obs2))';
O2(:, 1) = O2(:,1).^2 ./ Area;
O2(:, 2) = O2(:,2).^2 ./ Area;
obs3 = regionprops(cc, 'Area', 'Perimeter');
O3 = cell2mat(struct2cell(obs3))';
O3(:, 1) = (O3(:,2)) ./ O3(:,1);
O3(:, 2) = [];

%Observacions utilitzant característiques de la singatura polar

%Mira si en penses alguna més. Per internet no he trobat res jo
[B, L, N] = bwboundaries(BW);
dists = zeros(length(B), 360);
angles = zeros(length(B), 360);

for i = 1:length(B)
    boundary = B{i};
    [dist, angle] = signature(boundary);
    %Miret els plots per saber que ferne de les dades
    [v p] = max(dist/(max(dist)));
    dists(i,1:length(dist(p:end))) = dist(p:end)/(max(dist));
    dists(i,length(dist(p:end)):length(dist)) = dist(1:p)/(max(dist));
    dists(i,length(dist):end) = v;
    angles(i, 1:length(angle)) = angle;
    angles(i, length(angle):end) = (length(angle):360);
    figure;
    plot(angles(i,:),dists(i,:));
    sumes(i) = sum(dist)/length(dist);
    NumMaxims(i) = length(findpeaks(dist));
    Maxim(i) = max(dist);
    Maxim2(i) = max(dist(dist < max(dist)));
    Minims(i) = min(dist);
    DiffMinMax(i) = max(dist) - min(dist);
    stds(i) = std(dist); 
    means(i) = mean(dist);
end

Std = stds'.^2./Maxim';
S = sumes'.^2./Area;
NM = NumMaxims'.^2;
D = DiffMinMax'.^2./Maxim';
M = Maxim'./Area;
Min = Minims'./Area;
Mns = means'.^2./Area;

clear O
O = [O1 O2 O3];
%O = dists;

end