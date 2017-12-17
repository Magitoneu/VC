%%Function to know if a choosed point is part of a eye

function [ right ] = accurate( point, Leye, Reye)

boundingBoxAreaL = Leye(3) * Leye(4);
boundingBoxAreaR = Reye(3) * Reye(4);

if ((rectint(point,Leye) > boundingBoxAreaL/2) || (rectint(point,Reye) > boundingBoxAreaR/2))
    right = true;
else
    right = false;
end
end

