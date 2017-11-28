function [ O, dists, angles ] = get_Obs( I )

BW = I < 128;
BW = imclose(BW, strel('disk', 2));
BW = imclearborder(BW);
cc = bwconncomp(BW);
lab = bwlabel(BW);
BW = imfill(BW,'holes');

%Observacions utilitzant característiques de la singatura polar

[B, L, N] = bwboundaries(BW);
dists = zeros(length(B), 360);
angles = zeros(length(B), 360);
c = ['H', 'K', 'Q', 'B', 'R', 'P']';
for i = 1:length(B)
    boundary = B{i};
    [dist, angle] = signature(boundary);
    [v p] = max(dist/(std(dist)));
    dists(i,1:length(dist(p:end))) = dist(p:end)/(std(dist));
    dists(i,length(dist(p:end)):length(dist)) = dist(1:p)/(std(dist));
    dists(i,length(dist):end) = v;
    angles(i, 1:length(angle)) = angle;
    angles(i, length(angle):end) = (length(angle):360);
    figure,plot(angles(i,:),dists(i,:)), title(c(i));
end

O = [dists];

end

