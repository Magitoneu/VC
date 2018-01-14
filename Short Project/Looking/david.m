error = 0;
good = 0;
confusionMatrix = zeros(2);
for i=1:size(testDB,1)
    obs = getLookingObs(uint8(squeeze(testDB(i,:,:))));
    if (size(obs, 1) > size(obs, 2))
        obs = transpose(obs);
    end
    pred(i) = Model.predict(obs);
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
(good/(good + error)) * 100
confusionMatrix  
