I = uint8(squeeze(eyesDB(302,:,:)));
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
bestCentroid = props(idx).Centroid;
BW2 = zeros(size(BW));
BW2(CC.PixelIdxList{idx}) = 1;

I2 = imadjust(I);
I2 = imgaussfilt(I2);
I2 = imopen(I2, strel('disk', 5));
I2 = (I2 < 70);
%imshow(I2);
[centers, radii, metric] = imfindcircles(I2, [23 35], 'ObjectPolarity','bright', 'Method', 'TwoStage', 'Sensitivity', 0.90);
%imshow(I);
distToCenter = ones([size(centers, 1), 1]);

for i = 1:min(size(centers, 1), 3)
    distToCenter(i) = getDistance(centers(i, :), bestCentroid);
end

[better,posCenter] = min(distToCenter);

centersStrong5 = centers(posCenter,:); 
radiiStrong5 = radii(posCenter);
metricStrong5 = metric(posCenter);
I_eye = imgaussfilt(I, 2.5);
I_BW = edge(I_eye,'Canny', 0.15,0.1);
imshow(I);
st = props(idx);

rectangle('Position',[st.BoundingBox(1),st.BoundingBox(2),st.BoundingBox(3),st.BoundingBox(4)],...
'EdgeColor','r','LineWidth',2 )

viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');

