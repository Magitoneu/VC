function [ Il, Ir, Leye, Reye ] = getEyeImgs( I, pos)

D = pdist([pos(1), pos(2); pos(3), pos(4)],'euclidean');
Leye = [pos(1) - 0.65*D/2, pos(2) - 0.45*D/2 , 0.65*D, 0.45*D];
Reye = [pos(3) - 0.65*D/2, pos(4) - 0.45*D/2, 0.65*D ,0.45*D]; 
Il = imresize(imcrop(I,Leye), [30 40]);
Ir = imresize(imcrop(I,Reye), [30 40]);

end

