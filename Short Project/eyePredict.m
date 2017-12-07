
%n = randi([1 1000]);
I = uint8(squeeze(images(30,:,:)));
imshow(I);
hold on;
[rows, cols] = size(I);
k = 1;

for i = 10:10:220
   for j = 80:10:270
        Im = imcrop(I, [j-20 i-15 39 29]);
        O = getObs(Im);
        %[L, scores] = cpredictor.predict(O);
        [L, scores] = predict(vpredictor,O);
        %L = cell2mat(L);
        if L == 'y'
            points(k,1) = i;
            points(k,2) = j;
            points(k,3) = 0;
            k = k + 1;
        end
   end 

end

points = removeNoPairs(points);
plot(points(:,2), points(:,1), 'r*');
hold off;

