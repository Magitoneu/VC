clear NE LE L_LE L_NE
n = size(eyesDB,1);
p = 0.7;
trIdx = false(n,1);    
trIdx(1:round(p*n)) = true;     
trIdx = trIdx(randperm(n));   % randomise order
trainDB = eyesDB(trIdx,:,:); 
testDB = eyesDB(~trIdx,:,:); 


%LE (looking eye observations)
%NE (not looking eye observations)

%classifiedEyes(i) = 0 no mira.

%nobs = numero Observacions
%LE = zeros(length(classifiedEyes(:) == 1), nobs)
%NE = zeros(length(classifiedEyes(:) == 0), nobs)
%Quan fixem el numero d'observacions ho decomentem


for i=1:size(trainDB,1)
    I = uint8(squeeze(trainDB(i,:,:)));
    if(classifiedEyes(i) == 0)
        NE(i,:) = getLookingObs(I); 
    else
        LE(i,:) = getLookingObs(I);
    end
end

L_LE = repmat(1, size(LE,1), 1); 
L_NE = repmat(0, size(NE,1), 1);

cpredictor = TreeBagger(50, [LE; NE], [L_LE; L_NE]);

error = 0;
good = 0;
confusionMatrix = zeros(2);
for i=1:size(testDB,1)
    pred(i) = cpredictor.predict(getLookingObs(uint8(squeeze(testDB(i,:,:)))));
    if(str2num(cell2mat(pred(i))) ~= classifiedEyes(i))
        error = error + 1;
        if(str2num(cell2mat(pred(i))) == 1)
            confusionMatrix(1,2) = confusionMatrix(1,2) + 1; 
        else
            confusionMatrix(2,1) = confusionMatrix(2,1) + 1;
        end
    else
        good = good + 1;
        if(classifiedEyes(i) == 1)
            confusionMatrix(1,1) = confusionMatrix(1,1) + 1; 
        else
            confusionMatrix(2,2) = confusionMatrix(2,2) + 1;
        end
    end
end
confusionMatrix  
    
    
    