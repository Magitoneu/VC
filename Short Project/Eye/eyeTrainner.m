%%Cal crear les imatges de no ulls cada cop que es fa trainning per no
%%influir en els resultats de error.

%TODO: Reformar treebagger

%Mode
switch Mode
    case 1
        fprintf('Cascade Object Trainner \n');
    case 2
        fprintf('Decision Tree (TreeBagger)\n');
    case 3
        fprintf('Support Vector Machine \n');
    case 4
        fprintf('Adaboost \n');
    otherwise
        error('Invalid mode \n');
end

n = size(trainImgs,1);
negativeSamples = 160;

if(Mode ~= 1)
    nobs = 288;
    OE = zeros(n*2,nobs);
    ON1 = zeros(1,nobs);
    ON = zeros(n*negativeSamples,nobs);
    negativeSamples = 40;
end
k = 1;

for i = 1:n
   I = uint8(squeeze(trainImgs(i,:,:)));
   [IeyeL, IeyeR, Leye, Reye] = getEyeImgs(I,trainEyesLab(i,:));
   %Training eyes
   if(Mode ~= 1) 
       OE((i*2)-1,:) = getObs(IeyeL);
       OE((i*2),:) = getObs(IeyeR);
   end
   %Training no eyes
   for j = 1:negativeSamples
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
    fprintf('All negativa images created \n');
    negativeImages = imageDatastore(dir);
else
    L_eye = repmat(1, size(OE,1), 1); 
    L_neye = repmat(-1, size(ON,1), 1);
end

fprintf('Created observations and negative samples \n');
fprintf('Training Tree/SVM/Adaboost/CascadeDetector .... \n');

if(Mode == 2) 
    predictorEye = TreeBagger(20, [OE; ON], [L_eye; L_neye]);
elseif(Mode == 3) 
    vpredictor = fitcsvm([OE; ON], [L_eye; L_neye]);
elseif(Mode == 1) 
    fprintf('Trainning Cascade Detector \n');
    trainCascadeObjectDetector('eyeDetectorHOG.xml',positiveInstancesTrainning(:,1:2),negativeImages,'FeatureType','HOG','ObjectTrainingSize', [30 40],'NegativeSamplesFactor',2,'NumCascadeStages',6,'FalseAlarmRate',0.0150, 'TruePositiveRate', 0.9985);
else
    [classestimate, model] = adaboost('train',[OE;ON], [L_eye; L_neye], 100);
end
