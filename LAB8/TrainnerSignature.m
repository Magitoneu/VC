clear all

I = rgb2gray(imread('Chess figures.png'));
[Obs_Train, d, a] = get_Obs(I);

c = ['H', 'K', 'Q', 'B', 'R', 'P']';
predictor = TreeBagger(100, Obs_Train, c);
