function [ obs ] = getLookingObs2( I )
% De moment: Busquem l'iris i donem distÃ ncies als extrems de la imatge.
Ir = imresize(I, 5);
Io = histeq(Ir);
Laplacian = [-1 -1 -1; -1 8 -1; -1 -1 -1];
Ilp = imfilter(histeq(I), Laplacian);
IBW = (Ilp > 180);
IBW(1, :) = 0;
IBW(:, end) = 0;
IBW(end, :) = 0;
IBW(:, 1) = 0;
IBW = imresize(IBW, 5);
IBW = imopen(IBW, strel('disk', 1));
%imshow(IBW);
% IBW = (histeq(I) > 180);
% IBW(1, :) = 0;
% IBW(:, end) = 0;
% IBW(end, :) = 0;
% IBW(:, 1) = 0;
% IBW = imresize(IBW, 5);
% IBW = imopen(IBW, strel('disk', 1));
% imshow(IBW);
Io = imopen(Io, strel('disk', 6));
BW = (Io < 55);
BW = imfill(BW, 'holes');
[f, c] = size(BW);
center = [f/2 c/2];
CC = bwconncomp(BW);
props = regionprops(BW, 'Centroid', 'BoundingBox', 'Area');
distToCenter = ones([CC.NumObjects, 1]);
% Estem cercant per la regiÃ³ connexa amb Ã rea decent que s'apropi mÃ©s al
% centre.
for i = 1:CC.NumObjects
    if(props(i).Area > 500)
        distToCenter(i) = getDistance(props(i).Centroid, center);
    else
        distToCenter(i) = Inf;
    end
end
[~ ,idx] = min(distToCenter);
st = props(idx);
bestCentroid = props(idx).Centroid;
I2 = imadjust(Ir);
I2 = imgaussfilt(I2);
I2 = imopen(I2, strel('disk', 5));
I2 = (I2 < 70);
[centers, radii, metric] = imfindcircles(I2, [23 35], 'ObjectPolarity','bright', 'Method', 'TwoStage', 'Sensitivity', 0.90);
distToCenter = ones([size(centers, 1), 1]);
if (size(centers, 1) == 0)
    obs = [500 500 500 500 500 500 500]; 
    %obs = 100000;
end
InsideReal = imcrop(Ir, [st.BoundingBox(1),st.BoundingBox(2),st.BoundingBox(3),st.BoundingBox(4)]);
Inside = imcrop(IBW, [st.BoundingBox(1),st.BoundingBox(2),st.BoundingBox(3),st.BoundingBox(4)]);
Cinside = bwconncomp(Inside);
propsInside = regionprops(Inside, 'Centroid', 'BoundingBox', 'Area');
if(size(propsInside,1) > 1)
    areas = extractfield(propsInside, 'Area');
    centres = extractfield(propsInside, 'Centroid');
    [val1 pos1] = max(areas);
    areas(pos1) = 0;
    [val2 pos2] = max(areas);
    c1 = [centres(pos1*2-1)+st.BoundingBox(1) centres(pos1*2)+st.BoundingBox(2)];
    c2 = [centres(pos2*2-1)+st.BoundingBox(1) centres(pos2*2)+st.BoundingBox(2)];
    obs = sum(areas);
    %obs = [getDistance(c1, bestCentroid), getDistance(c2, bestCentroid), getDistance(c1,c2)];
    obs = [sum(areas) c1 c2 getDistance(c1, bestCentroid) getDistance(c2, bestCentroid)];
elseif (size(propsInside,1) > 0)
    areas = extractfield(propsInside, 'Area');
    centres = extractfield(propsInside, 'Centroid');
    [val1 pos1] = max(areas);
    areas(pos1) = 0;
    c1 = [centres(pos1*2-1)+st.BoundingBox(1) centres(pos1*2)+st.BoundingBox(2)];
    obs = [sum(areas) c1  c1 getDistance(c1, bestCentroid) getDistance(c1, bestCentroid)];
else
    obs = [500 500 500 500 500 500 500];
    
end
end
