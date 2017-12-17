error = zeros(CVO.NumTestSets,1);

lenTest = size(testImgs,1);

if(Mode ~= 1)
    for r = 1:1:lenTest
        I = uint8(squeeze(testImgs(r,:,:)));
        [rows, cols] = size(I);
        k = 1;
        for i = 10:15:220
           for j = 80:15:270
                Im = imcrop(I, [j-20 i-15 39 29]);
                O = getObs(Im);
                if(Mode == 2)
                    [L, scores] = cpredictor.predict(O); %TreeBagger
                else
                    [L, scores] = predict(vpredictor,O); %SVM
                end
                %L = adaboost('apply',O,model);
                %L = cell2mat(L);
                if L == 1
                    points(k,1) = i;
                    points(k,2) = j;
                    points(k,3) = 0;
                    k = k + 1;
                end
           end 
        end
        points = removeNoPairs(points);
        I = insertMarker(I,[points(:,2) points(:,1)]);
        imshow(I);
        %plot(points(:,2), points(:,1), 'r*');
    end
else
    confusionMatrix = zeros(2);
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
    confusionMatrix(1,2) = size(testEyes,1) * 2) - confusionMatrix(1,1);
end
