function mean_ESF = alignEdgeAndUpsample(ROIimg,edgeEst,sampleFactor)

    if nargin < 3
        sampleFactor = 4;
    end

    %%
    offsets = polyval(edgeEst,1:size(ROIimg,2));
    normOffsets = offsets - offsets(1);
    
    ESF = zeros(size(ROIimg,2),size(ROIimg,1)*sampleFactor);
    
    ESF(1,1:sampleFactor:end) = ROIimg(1,:);
    
    for i = 2:size(ROIimg,2)
        shift = round(normOffsets(i)*sampleFactor);

        ESF(i,(1-shift):sampleFactor:size(ESF,2)) = ROIimg(i,1:ceil(size(ROIimg,1)+shift/sampleFactor));

    end

    mean_ESF = zeros(1,size(ESF,2));
    for x = 1:size(ESF,2)
        mean_ESF(x) = mean(ESF(ESF(:,x)>0,x));
    end

    %%
    
    dCorr = sampleFactor*cos(atan(mean(gradient(polyval(edgeEst,1:length(ROIimg))))));
    samplingInterval = 1/dCorr;
    
    x = repmat(linspace(1,size(ROIimg,1),size(ROIimg,2)),size(ROIimg,1),1);
    y = imrotate(x,-90);
    z = 1;
    binMeans = zeros(ceil(dCorr)*size(ROIimg,1),1);
    for i = ceil(ceil(dCorr)*size(ROIimg,1)/2)-1:-1:-ceil(ceil(dCorr)*size(ROIimg,1)/2)
        pointMap1 = x <= polyval(edgeEst,y) - samplingInterval*i;
        pointMap2 = x >= polyval(edgeEst,y) - samplingInterval*(i+1);
        pointMap3 = pointMap1.*pointMap2;
%         imshow(pointMap3);
        mean_ESF(z) = mean(ROIimg(pointMap3==1));
        z = z+1;
    end
    mean_ESF(isnan(mean_ESF)) = 0;
end
