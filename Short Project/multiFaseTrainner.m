clc, clear all
getEyes;
Mode = 2; multiFase = 1;
trainEyes = eyesDB;
trainImgs = images;
trainEyesLab = eyes;
eyeTrainner;
lookingTrainner;
%Predictors (predictorEye predictorLooking)
    