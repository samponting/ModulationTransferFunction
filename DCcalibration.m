function DCcalibration


tmp = load('processedImages/cameraTarget.mat');tmp = tmp.out_img;
load('processedImages/darkCurrent.mat');
img = tmp - out_img;
out_img = img;
save([pwd,'/processedImages/calibratedTarget.mat'],'out_img');

end