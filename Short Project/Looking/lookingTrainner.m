clear NE LE L_LE L_NE pred trainDB testDB trainLabels testLabels
n = size(eyesDB,1);
p = 0.7;
trIdx = false(n,1);    
trIdx(1:round(p*n)) = true;     
trIdx = trIdx(randperm(n));   % randomise order
trainDB = eyesDB(trIdx,:,:);
testDB = eyesDB(~trIdx,:,:); 

trainLabels = classifiedEyes(trIdx);
testLabels = classifiedEyes(~trIdx);

%LE (looking eye observations)
%NE (not looking eye observations)

%classifiedEyes(i) = 0 no mira.

%nobs = numero Observacions
%LE = zeros(length(classifiedEyes(:) == 1), nobs)
%NE = zeros(length(classifiedEyes(:) == 0), nobs)
%Quan fixem el numero d'observacions ho decomentem

x = 1;
y = 1;

if(multiFase)
    trainDB = images;
    trainLabels = classifiedEyes;
end

for i=1:size(trainDB,1)
    I = uint8(squeeze(trainDB(i,:,:)));
    if(trainLabels(i) == 0)
<<<<<<< HEAD
        NE(x,:) = getLookingObs(I); 
        x = x+1;
    else
        LE(y,:) = getLookingObs(I);
=======
        NE(x,:) = getLookingObs3(I);
        x = x+1;
    else
        LE(y,:) = getLookingObs3(I);
>>>>>>> 08fe6882584f22a3d19c18b9cc43d272be5235f6
        y = y+1;
    end
end

L_LE = repmat(1, size(LE,1), 1); 
L_NE = repmat(0, size(NE,1), 1);
predictorLooking = TreeBagger(50, [LE; NE], [L_LE; L_NE]);



<<<<<<< HEAD
=======
cpredictor = TreeBagger(50, [LE; NE], [L_LE; L_NE]);
error = 0;
good = 0;
confusionMatrix = zeros(2);
for i=1:size(testDB,1)
    I = (uint8(squeeze(testDB(i,:,:))));
    obs = getLookingObs3(I);
    if (size(obs, 1) > size(obs, 2))
        obs = transpose(obs);
    end
    
    [pred, scores] = cpredictor.predict(obs);
    pred = str2num(cell2mat(pred));
    if(pred ~= testLabels(i))
        error = error + 1;
        if(pred == 1)
            confusionMatrix(1,2) = confusionMatrix(1,2) + 1; 
        else
            confusionMatrix(2,1) = confusionMatrix(2,1) + 1;
        end
    else
        good = good + 1;
        if(testLabels(i) == 1)
            confusionMatrix(1,1) = confusionMatrix(1,1) + 1; 
        else
            confusionMatrix(2,2) = confusionMatrix(2,2) + 1;
        end
    end
end
(good/(good + error)) * 100
confusionMatrix
    
>>>>>>> 08fe6882584f22a3d19c18b9cc43d272be5235f6
    
    