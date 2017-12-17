%%Cal crear les imatges de no ulls cada cop que es fa trainning per no
%%influir en els resultats de error.


%TODO: Reformar treebagger

%Check valid Mode
if(Mode > 4 || Mode < 0)
    disp('Invalid Mode');
end

n = length(trainImgs);

if(Mode ~= 1)
    nobs = 544;
    OE = zeros(n*2,nobs);
    ON1 = zeros(1,nobs);
    ON = zeros(n*36,nobs);
end
k = 1;

for i = 1:n
   I = uint8(squeeze(trainImgs(i,:,:)));
   [IeyeL, IeyeR, Leye, Reye] = getEyeImgs(I,trainEyes(i,:));
   %Training eyes
   if(Mode == 2 || Mode == 3) 
       OE((i*2)-1,:) = getObs(IeyeL);
       OE((i*2),:) = getObs(IeyeR);
   end
   %Training no eyes
   for j = 1:160
       imgN = getNeyeImg(I,Leye,Reye,Mode);
       if(Mode == 1)
           filename = strcat(dir, int2str(k), '.pgm');
           imwrite(imgN,filename);
       else   
           ON(k,:) = getObs(imgN);
       end
       k = k + 1;
   end
end

if(Mode == 1)
    disp('All negativa images created');
    negativeImages = imageDatastore(dir);
else
    L_eye = repmat('y', length(OE), 1); 
    L_neye = repmat('n', length(ON), 1);
end

if(Mode == 2) 
    cpredictor = TreeBagger(600, [OE; ON], [L_eye; L_neye]);
elseif(Mode == 3) 
    vpredictor = fitcsvm([OE; ON], [L_eye; L_neye]);
elseif(Mode == 1) 
    disp('Trainning Cascade Detector');
    trainCascadeObjectDetector('eyeDetectorHOG.xml',positiveInstancesTrainning(:,1:2),negativeImages,'FeatureType','HOG','ObjectTrainingSize', [30 40],'NegativeSamplesFactor',2,'NumCascadeStages',6,'FalseAlarmRate',0.0150, 'TruePositiveRate', 0.9985);
else
    [classestimate, model] = adaboost('train',[OE;ON], [L_eye; L_neye], 100);
end
