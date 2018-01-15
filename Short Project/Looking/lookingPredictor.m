error = 0;
good = 0;
confusionMatrix = zeros(2);
for i=1:size(testDB,1)
    obs = extractHOGFeatures(squeeze(testDB(i,:,:)));
    if (size(obs, 1) > size(obs, 2))
        obs = transpose(obs);
    end
    
    [pred(i), scores(i,:)] = cpredictor.predict(obs);
    p = (scores(i,2) > 0.5);
    if(p ~= testLabels(i))
        error = error + 1;
        if(p == 1)
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