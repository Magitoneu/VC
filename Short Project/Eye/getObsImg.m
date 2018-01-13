function [ obs, points ] = getObsImg( I )


[rows,cols] = size(I);
k = 1;
for i=1:5:rows-30
    for j=1:5:cols-40
        obs(k,:) = getObs(imcrop(I,[j i 39 29]));
        points(k,:) = [i j];
        k = k + 1;
    end
end
end

