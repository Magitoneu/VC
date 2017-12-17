%%Cross-Validation

%Chose training mode 1(CascadeDetector) 2(TreeBagger) 3(Support Vector
%Machine) 4(Adaboost with HOG & Hist)
Mode = 3;


disp('Getting Files...')
getFiles;
CVO = cvpartition(3042, 'k', 10);
nameBase = '../../Images/NegativeImages';
disp('Cross Validation Starting with 10 folds');
for i = 1:CVO.NumTestSets
    if(Mode == 1)
        try 
            rmdir('../../Images/NegativeImages/', 's');
        catch 
            disp('No dir to remove');
        end
        try 
            delete eyeDetector*.xml
        catch 
            disp('No Detector to remove');
        end
        try 
            rmdir('eyeDetector*', 's');
        catch 
            disp('No Detector to remove');
        end
    end
    dir = strcat(nameBase, int2str(i), '/');
    mkdir(dir);
    trIdx = CVO.training(i);
    teIdx = CVO.test(i);
    trainImgs = images(trIdx, :, :);
    testImgs = images(teIdx, : , :);
    trainEyes = eyes(trIdx, :);
    testEyes = eyes(teIdx, :);
    if(Mode == 1)
        AB = zeros(size(trIdx,1)*2,1);
        AB(1:2:end,:) = trIdx;
        AB(2:2:end,:) = trIdx;
        positiveInstancesTrainning = positiveInstances(logical(AB), :);
    end
    fprintf('Starting training fase... \n');
    eyeTrainner; %Agafant training
    fprintf('Starting prediction fase... \n');
    eyePredict; %Agafant testing
    fprintf('Cross Validation Fase Finished, Confusion Matrix: ');
    confusionMatrixs(:,:,i) = confusionMatrix;
end
confusionMatrix = sum(confusionMatrixs(:,:,:),3);

%cvErr = sum(error)/sum(CVO.TestSize);