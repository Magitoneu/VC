I = uint8(squeeze(eyesDB(1200,:,:)));
Ir = imresize(I, 5);
Io = histeq(Ir);

Laplacian = [-1 -1 -1; -1 8 -1; -1 -1 -1];
Ilp = imfilter(histeq(I), Laplacian);
IBW = (Ilp > 200);


IBW(1, :) = 0;
IBW(:, end) = 0;
IBW(end, :) = 0;
IBW(:, 1) = 0;
IBW = imresize(IBW, 5);
IBW = imopen(IBW, strel('disk', 1));
figure, imshow(IBW);


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

I2 = imadjust(Ir);
I2 = imgaussfilt(I2);
I2 = imopen(I2, strel('disk', 5));
I2 = (I2 < 70);
%imshow(I2);
[centers, radii, metric] = imfindcircles(I2, [23 35], 'ObjectPolarity','bright', 'Method', 'TwoStage', 'Sensitivity', 0.90);
figure, imshow(Ir);
distToCenter = ones([size(centers, 1), 1]);

for i = 1:min(size(centers, 1), 3)
    distToCenter(i) = getDistance(centers(i, :), bestCentroid);
end

[better,posCenter] = min(distToCenter);

centersStrong5 = centers(posCenter,:); 
radiiStrong5 = radii(posCenter);
metricStrong5 = metric(posCenter);

st = props(idx);

rectangle('Position',[st.BoundingBox(1),st.BoundingBox(2),st.BoundingBox(3),st.BoundingBox(4)],...
'EdgeColor','r','LineWidth',2 )
viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');

InsideReal = imcrop(Ir, [st.BoundingBox(1),st.BoundingBox(2),st.BoundingBox(3),st.BoundingBox(4)]);
Inside = imcrop(IBW, [st.BoundingBox(1),st.BoundingBox(2),st.BoundingBox(3),st.BoundingBox(4)]);
figure, imshow(Inside);
Cinside = bwconncomp(Inside);
propsInside = regionprops(Inside, 'Centroid', 'BoundingBox', 'Area');

areas = extractfield(propsInside, 'Area');
centres = extractfield(propsInside, 'Centroid');

[val1 pos1] = max(areas);
areas(pos1) = 0;
[val2 pos2] = max(areas);

c1 = [centres(pos1*2-1)+st.BoundingBox(1) centres(pos1*2)+st.BoundingBox(2)];
c2 = [centres(pos2*2-1)+st.BoundingBox(1) centres(pos2*2)+st.BoundingBox(2)];

Ir = insertMarker(Ir, c1);
Ir = insertMarker(Ir, c2);
figure, imshow(Ir), title('this');

