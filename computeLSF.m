function win_LSF = computeLSF(ESF)

    FIR = [-1/2 0 1/2];
    LSF = conv(ESF,FIR,'same');
    LSF(1) = LSF(2);
    LSF(end) = LSF(end-1);

    [~,maxIdx] = max(abs(LSF));
    
    if LSF(maxIdx) < 0
        LSF = -LSF;
    end

    centDif = maxIdx - ceil(length(LSF)/2);
    corr_LSF = circshift(LSF,-centDif);

    TF = tukeyFilter(length(corr_LSF),1);

    win_LSF = corr_LSF.*TF';

end