%I = imread() .... Les nostres, despres risize
I = imread('/home/mt7/Pictures/Webcam/NL1.jpg');
I = imcrop(I, [245 0 1430 1080]);
I = rgb2gray(I);
I = imresize(I, [286 384]);

figure, imshow(I);
[O, points] = getObsImg(I);
[L, scores] = predictorEye.predict(O);
pscored = cellfun(@str2num,L) == 1;
if(max(pscored)== 0)
   pscored = scores(:,2) > 0.45;
   if(max(pscored) == 0)
       psocored = scores(:,2) > 0.40;
       if(max(pscored) == 0)
         psocored = scores(:,2) > 0.34;
       end
   end
end


points = points(pscored, 1:2); %TreeBagger
points = [points zeros(size(points,1),1)];
points(:,1) = points(:,1) + 15; %+15
points(:,2) = points(:,2) + 20; %+20
if(size(points,1) ~= 0)
    points = removeNoPairs(points);
    if(size(points,1) ~= 0)
        [p1 p2] = kClustering(points);
    else
        p1  = [0 0]; p2 = [0 0];
    end
end
if(size(points,1) == 0)
    disp('No eyes detected');
else
    figure, imshow(I);
    EyeL = imcrop(I, [p1(2)-20 p1(1)-15 39 29]);
    EyeR = imcrop(I, [p2(2)-20 p2(1)-15 39 29]);
    figure, subplot(2,1,1), imshow(EyeL);
    subplot(2,1,2), imshow(EyeR);
    obsL = getLookingObs(EyeL);
    obsR = getLookingObs(EyeR);
    [predL, scoreL] = predictorLooking.predict(obsL);
    [predR, scoreR] = predictorLooking.predict(obsR);
    if(str2num(cell2mat(predL)) == 1)
        if(str2num(cell2mat(predR)) == 1)
            disp('Looking');
        else
            if(scoreL > scoreR)
                disp('Looking')
            else
                disp('NOT looking');
            end
        end
    else
        if(str2num(cell2mat(predR)) == 1)
            if(scoreL < scoreR)
                disp('Looking')
            end
        end
        disp('NOT looking');
    end
    
end
