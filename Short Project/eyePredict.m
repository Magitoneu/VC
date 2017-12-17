error = zeros(CVO.NumTestSets,1);

lenTest = size(testImgs,1);
confusionMatrix = zeros(2);

if(Mode ~= 1)
    for r = 1:1:lenTest
        I = uint8(squeeze(testImgs(r,:,:)));
        [rows, cols] = size(I);
        k = 1;
        points = zeros(3,1)';
        for i = 16:7:200
           for j = 30:7:270
                Im = imcrop(I, [j-20 i-15 39 29]);
                O = getObs(Im);
                if(Mode == 2)
                    [L, scores] = cpredictor.predict(O); %TreeBagger
                elseif(Mode == 3)
                    [L, scores] = predict(vpredictor,O); %SVM
                else
                    L = adaboost('apply',O,model);
                end
                if(Mode == 2) 
                    L = cell2mat(L);
                end
                if L == 1 || L == 'y'
                    points(k,1) = i;
                    points(k,2) = j;
                    points(k,3) = 0;
                    k = k + 1;
                    [Leye, Reye] = getBbox(testEyes(r,:));
                    if(accurate([j-20 i-15 39 29], Leye, Reye))
                        confusionMatrix(1,1) = confusionMatrix(1,1) + 1;
                    else
                        confusionMatrix(2,1) = confusionMatrix(1,2) + 1;
                    end
                else
                    if(accurate([j-20 i-15 39 29], Leye, Reye))
                        confusionMatrix(1,1) = confusionMatrix(2,1) + 1;
                    else
                        confusionMatrix(2,1) = confusionMatrix(2,2) + 1;
                    end
                end
           end 
        end
        if(points(1,1) ~= 0)
            points = removeNoPairs(points);
            I = insertMarker(I,[points(:,2) points(:,1)]);
        end
        imshow(I);
        %plot(points(:,2), points(:,1), 'r*');
    end
else
    detector = vision.CascadeObjectDetector('eyeDetectorHOG.xml');
    for r = 1:1:lenTest
        img = uint8(squeeze(testImgs(r,:,:)));
        bbox = step(detector,img);
        bbox = removeFails([bbox zeros(size(bbox,1),1)]);
        for k = 1:size(bbox,1)
            [Leye, Reye] = getBbox(testEyes(r,:));
            if(accurate(bbox(k,:), Leye, Reye))
                confusionMatrix(1,1) = confusionMatrix(1,1) + 1;
            else
                confusionMatrix(2,1) = confusionMatrix(1,2) + 1;
            end
        end
        %detectedImg = insertObjectAnnotation(img, 'rectangle', bbox, 'eye');
        %imshow(detectedImg)
    end    
    confusionMatrix(1,2) = size(testEyes,1) * 2 - confusionMatrix(1,1);
end
