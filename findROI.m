function imCropped = findROI(targetImage,ROIsideLength,mode)

load([pwd,'/processedImages/',targetImage,'.mat']);

% Convert to luminance image based off ISO 12232 standard
Yim = ((2126/10000).*out_img(:,:,1))+((7152/10000).*out_img(:,:,2))+((722/10000).*out_img(:,:,3));


if strcmp(mode,'line')
    % Binarize and blur image to isolate line function.
    bIm = imbinarize(Yim);
    blurIm = imgaussfilt(double(bIm),10);
    
    [~,idx] = max(blurIm');
    ROIx = round(mean(idx));
    
    imCropped = Yim(((size(Yim,1)/2)-ROIsideLength/2):((size(Yim,1)/2)+ROIsideLength/2)-1,(ROIx-ROIsideLength/2):(ROIx+ROIsideLength/2)-1);

elseif strcmp(mode,'target')
    imshow(Yim)
    roi = drawpoint;
    imCropped = imcrop(Yim,[roi.Position-ROIsideLength/2 ROIsideLength ROIsideLength]);
    close all;
end


figure('Name','ROI');imshow(imCropped);
pause(1)
close ROI

ROIimg = imCropped;
save([pwd,'/processedImages/ROIimg.mat'],'ROIimg')

end