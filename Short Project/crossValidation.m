%%Cross-Validation

%TODO: 
%   -canvi de generacio de observacions negatives. (Agafar imatges més gran com CascadeDetector)
%   -criteri de ull-noull (matrius de confusió). 
%   -mitjana dels punts per cada ull
%   -classificació de mirar/no mirar, HOUGH/SIFT?
%   -treeBagger calcul de error amb diferents arbres i obs, sense
%   cross-validation, nomes train/test 
%   -Fscore, ROC-curve

%TreeBagger Ferlo amb HOG i histogrames normalitzats
%Chose training mode 1(CascadeDetector) 2(TreeBagger) 3(Support Vector
%Machine) 4(Adaboost with HOG & Hist)
Mode = 2;


disp('Getting Files...')
%getFiles;
CVO = cvpartition(3042, 'k', 10);
nameBase = '../../Images/NegativeImages';
disp('Cross Validation Starting with 10 folds');
for cvo_i = 1:CVO.NumTestSets
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
    dir = strcat(nameBase, int2str(cvo_i), '/');
    mkdir(dir);
    trIdx = CVO.training(cvo_i);
    teIdx = CVO.test(cvo_i);
    trainImgs = images(trIdx, :, :);
    testImgs = images(teIdx, : , :);
    trainEyes = eyes(trIdx, :);
    testEyes = eyes(teIdx, :);
    lenTest = size(testImgs,1);
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
    confusionMatrixs(:,:,cvo_i) = confusionMatrix/lenTest;
    T = array2table(confusionMatrix, 'VariableNames', {'Ull', 'Null'});
    T.Properties.RowNames = {'ULL', 'NULL'};
    T
end
confusionMatrix = sum(confusionMatrixs(:,:,:),3)/CVO.NumTestSets;
T = array2table(confusionMatrix, 'VariableNames', {'Ull', 'Null'});
T.Properties.RowNames = {'ULL', 'NULL'};
T
%cvErr = sum(error)/sum(CVO.TestSize);