
n = length(images);
OE1 = zeros(n,545);
OE2 = zeros(n,545);
OE = zeros(n*2,545);
ON1 = zeros(1,545);
ON = zeros(n*7,545);


for i = 1:n
   I = uint8(squeeze(images(i,:,:)));
   [IeyeL, IeyeR, Leye, Reye] = getEyeImgs(I,eyes(i,:));
   %Training eyes
   OE1 = getObs(IeyeL);
   OE2 = getObs(IeyeR);
   OE = [OE; OE1; OE2];
   %Training no eyes
   for j = 1:13
    imgN = getNeyeImg(I,Leye,Reye);
    ON1 = getObs(imgN);
    ON = [ON; ON1];
   end
end

L_eye = repmat('y', length(OE), 1); 
L_neye = repmat('n', length(ON), 1);
cpredictor = TreeBagger(600, [OE; ON], [L_eye; L_neye]);