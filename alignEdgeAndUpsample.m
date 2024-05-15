function mean_ESF = alignEdgeAndUpsample(ROIimg,edgeEst,sampleFactor)

    if nargin < 3
        sampleFactor = 4;
    end

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
end
