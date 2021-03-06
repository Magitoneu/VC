function [ obs ] = getLookingObs( I )
I = imresize(I, 5);
Io = histeq(I);

Io = imopen(Io, strel('disk', 6));
BW = (Io < 55);
BW = imfill(BW, 'holes');

[f, c] = size(BW);
center = [f/2 c/2];

CC = bwconncomp(BW);
props = regionprops(BW, 'Centroid', 'BoundingBox', 'Area');

distToCenter = ones([CC.NumObjects, 1]);

for i = 1:CC.NumObjects
    if(props(i).Area > 500)
        distToCenter(i) = getDistance(props(i).Centroid, center);
    else
        distToCenter(i) = Inf;
    end
    
end

[~ ,idx] = min(distToCenter);
st = props(idx);

Icropped = imcrop(I, st.BoundingBox);
hist = imhist(Icropped);
obs = hist';
% 
% I2 = imadjust(I);
% I2 = imgaussfilt(I2);
% I2 = imopen(I2, strel('disk', 5));
% I2 = (I2 < 70);
% [centers, radii, metric] = imfindcircles(I2, [23 35], 'ObjectPolarity','bright', 'Method', 'TwoStage', 'Sensitivity', 0.90);
% distToCenter = ones([size(centers, 1), 1]);
% 
% % Ara cerquem pel cercle d'iris dels 3 millors que ha trobat que s'apropi
% % més al centre de la regió connexa que ens defineix la BB de l'ull.
% 
% if (size(centers, 1) == 0)
%     obs = [500 500 500 500 500 500 500];
% else
%     for i = 1:min(size(centers, 1), 3)
%         distToCenter(i) = getDistance(centers(i, :), st.Centroid);
%     end
% 
%     [distanciaIrisCentroid, posCenter] = min(distToCenter);
% 
%     centerIris = centers(posCenter,:); 
%     radiIris = radii(posCenter);
%     %metricIris = metric(posCenter);
%     
%     upperLeft = [st.BoundingBox(1) st.BoundingBox(2)];
%     upperRight = [st.BoundingBox(1) st.BoundingBox(2)+st.BoundingBox(3)];
%     lowerLeft = [st.BoundingBox(1)+st.BoundingBox(4) st.BoundingBox(2)];
%     lowerRight = [st.BoundingBox(1)+st.BoundingBox(4) st.BoundingBox(2)+st.BoundingBox(3)];
% 
%     obs = [abs(centerIris(2)-st.Centroid(2)) abs(centerIris(1)-st.Centroid(1)) distanciaIrisCentroid ...
%         getDistance(centerIris, upperLeft) getDistance(centerIris, upperRight) ...
%         getDistance(centerIris, lowerLeft) getDistance(centerIris, lowerRight) ];
% end
%         
end
