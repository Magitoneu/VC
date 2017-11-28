%I = rgb2gray(imread('Chess figures.png'));

I = rgb2gray(imread('Horse.png'));
t = affine2d([1 0 0;0.2 1 0; 0 0 1]);
I = imwarp(I,t);
figure, imshow(I);
figure;
Obs_Pred = get_Obs(I);

res = 0; suma_maxims = 0; suma_2ndMax = 0;

[L, scores] = predictor.predict(Obs_Pred);
sc_sort = sort(scores, 2);
maxims = sc_sort(:, 6);
sc_sort(:, 6) = 0;
suma_maxims = suma_maxims + sum(maxims);
suma_2ndMax = suma_2ndMax + sum(max(sc_sort, [], 2));
res = res + (suma_maxims - suma_2ndMax);
