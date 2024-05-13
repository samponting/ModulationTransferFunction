close all;clear;clc;

mode = 'target'; % 'line' or 'target'
numIms = 20;
imageDir = dir([pwd,'/images/']);

%% Load in and process images
% Gamma correction needs to be added 
if ~exist('processedImages')
    processRawImages(numIms,imageDir(4:end));
end

if exist('processedImages/darkCurrent.mat') && ~exist('/processedImages/calibratedTarget.mat')
    DCcalibration
end


%% Generate Luminance images and find ROI
targetImage = 'calibratedTarget';

ROIsideLength = 200; %100-400 pixel range

ROIimg = findROI(targetImage,ROIsideLength,mode);

%% Tukey Window and Find Derivative

%compute 1-D derivative
FIR = [-0.5 0.5];
derivImg = compute1Dderivative(ROIimg,FIR);


%tukey window
alpha = 1;
w = tukeyFilter(size(derivImg,1),alpha);

filtIm = zeros(size(derivImg,1),size(derivImg,2));
for y = 1:size(derivImg,1)
    filtImg(y,:) = w'.*derivImg(y,:);
end

%find edge centroid
c = findCentroid(filtImg);

%second tukey filtering
filtIm2 = zeros(size(derivImg,1),size(derivImg,2));
for y = 1:size(derivImg,1)
    w = tukeyFilter(size(derivImg,1),alpha,c(y));
    filtImg2(y,:) = w'.*derivImg(y,:);
end

%find edge centroid
c = findCentroid(filtImg2);

%polynomial fit to edge estimate
polyDegree = 5;
edgeEst = polyfit(1:size(c),c,polyDegree);

rad2deg(atan(edgeEst(5)))







