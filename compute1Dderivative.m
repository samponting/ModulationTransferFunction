function derivImg = compute1Dderivative(img,FIR)

    derivImg = zeros(size(img,1),size(img,2));
    for x = 1:size(img,1)
        tmp = conv(img(x,:),FIR,'same');
        derivImg(x,:) = tmp;
    end

    derivImg(:,1) = derivImg(:,2);
    derivImg(:,size(img,1)) = derivImg(:,size(img,1)-1);
    
    if mean(derivImg,[1,2]) < 0
        derivImg = -derivImg;
    end


end