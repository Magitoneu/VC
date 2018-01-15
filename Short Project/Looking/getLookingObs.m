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

end
