error = zeros(CVO.NumTestSets,1);

lenTest = size(testImgs,1);
confusionMatrix = zeros(2);
auxCnt = 0;
if(Mode ~= 1)
    for r = 1:1:lenTest
        
        I = uint8(squeeze(testImgs(r,:,:)));
        [rows, cols] = size(I);
        k = 1;
        [O, points] = getObsImg(I);
        [L, scores] = cpredictor.predict(O);
        if(Mode == 2)
            points = points(cellfun(@str2num,L) == 1, 1:2); %TreeBagger
        elseif(Mode == 3)
            [L, scores] = predict(vpredictor,O); %SVM
        else
             L = adaboost('apply',O,model);
        end
        points = [points zeros(size(points,1),1)];
        points(:,1) = points(:,1) + 15;
        points(:,2) = points(:,2) + 20;
        GetR = false; GetL = false;
        if(size(points,1) ~= 0)
            points = removeNoPairs(points);
            I = insertMarker(I,[points(:,2) points(:,1)]);
            [Leye, Reye] = getBbox(testEyes(r,:));
            for cnt=1:size(points,1)
                [acc, eye] = inside(points(cnt,:), Leye, Reye);
                if(acc)
                    confusionMatrix(1,1) = confusionMatrix(1,1) + 1;
                    if(eye == 'R')
                        GetR = true;
                    elseif(eye == 'L')
                        GetL = true;
                    end
                else
                    confusionMatrix(1,2) = confusionMatrix(1,2) + 1;
                end
            end
        end   
        confusionMatrix(2,2) = confusionMatrix(2,2) + ((rows-30)/5 * (cols-40)/5 - confusionMatrix(1,2));
        if(~GetR && ~GetL)
            confusionMatrix(2,1) = confusionMatrix(2,1) + 2;
        elseif(~GetR || ~GetL)
            confusionMatrix(2,1) = confusionMatrix(2,1) + 1;
        else
            confusionMatrix(2,1) = confusionMatrix(2,1);
        end
        imshow(I);
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
                confusionMatrix(1,2) = confusionMatrix(1,2) + 1;
            end
        end
        %detectedImg = insertObjectAnnotation(img, 'rectangle', bbox, 'eye');
        confusionMatrix(2,1) = size(testEyes,1) * 2 - confusionMatrix(1,1); %Malament??
        confusionMatrix(2,2) = size(img,1) * size(img,2) - size(bbox,1);
        %imshow(detectedImg)
    end        
end
