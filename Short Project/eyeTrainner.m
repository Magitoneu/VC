
n = length(images);


for i = 1:n
    
   I = uint8(squeeze(images(i,:,:)));
   pos = asdasd(i,1:4);
   D = pdist([pos(1), pos(2); pos(3), pos(4)],'euclidean');
   Leye = [pos(1) - 0.65*D/2, pos(2) - 0.65*D/2, pos(1) + 0.65*D/2, pos(2) + 0.65*D/2];
   Reye = [pos(3) - 0.65*D/2, pos(4) - 0.65*D/2, pos(3) + 0.65*D/2, pos(4) + 0.65*D/2];
   
   IeyeL = imcrop(I,Leye);
   IeyeR = imcrop(I,Reye);
   
   imshow(IeyeL,[]);
   %Training eyes
   %Obs1 = getObs(IeyeL);
   %Obs2 = getObs(IeyeR);
   %Training no eyes
   
end

