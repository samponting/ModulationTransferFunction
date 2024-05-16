function corr_mtf = discreteFourierTransform(LSF)

    endPoint = ceil(length(LSF)/2);

    temp = zeros(1,length(LSF));
    mtf = zeros(1,endPoint);
    sincFun = zeros(1,endPoint);

    for k = 1:endPoint
        for n = 1:length(LSF)
            temp(n) = LSF(n)*exp((-1i*2*pi*k*n)/length(LSF));
        end
        mtf(k) = sum(temp)./sum(LSF);
        sincFun(k) = 1/(sinc((2*pi*k)/length(LSF)));
    end
    mtf = abs(mtf);

    dCorr = 10*ones(1,length(sincFun));
    dCorr(sincFun<10) = sincFun(sincFun<10);
%     dCorr = abs(dCorr);
    corr_mtf = mtf.*dCorr;

%     norm_mtf = corr_mtf./max(corr_mtf);

    % This is the bit im not sure about... the dCorr stuff is slightly hard
    % to get your head around in terms of where the absolute values should
    % be taken.
end