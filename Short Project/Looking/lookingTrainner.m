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

for i=1:size(trainDB,1)
    I = uint8(squeeze(trainDB(i,:,:)));
    if(trainLabels(i) == 0)
        NE(x,:) = extractHOGFeatures(I); 
        x = x+1;
    else
        LE(y,:) = extractHOGFeatures(I);
        y = y+1;
    end
end


L_LE = repmat(1, size(LE,1), 1); 
L_NE = repmat(0, size(NE,1), 1);

cpredictor = TreeBagger(50, [LE; NE], [L_LE; L_NE]);
error = 0;
good = 0;
confusionMatrix = zeros(2);
for i=1:size(testDB,1)
    obs = extractHOGFeatures(squeeze(testDB(i,:,:)));
    if (size(obs, 1) > size(obs, 2))
        obs = transpose(obs);
    end
    
    [pred, scores] = cpredictor.predict(obs);
    pred = (scores(:,2) > 0.5);
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
    
    
    