function Fk = computeSpatialFrequencyValues(sampleFactor, slope, n)

    d = (1/sampleFactor)*1*cos(slope);
    k = 1:n;

    Fk = k./(d*n);



end