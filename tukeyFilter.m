function w = tukeyFilter(n,alpha,mid)
    
    if nargin ==2
        mid = n/2;
    end

    mm = max(mid, n-mid);
    n2 = round(mm*2);
    m = (n2-1)/2;


    w = zeros(n,1);
    for x = 0:m
        if x < alpha*m
            w(x+1) = 0.5*(1-cos((2*pi*x)/(alpha*(m-1))));
        else
            w(x+1) = 1;
        end
        w(n2-x) = w(x+1);
    end

    if mid>=n/2
        w = w(1:n);
    else
        w = w(n2-n+1:n2);
    end


end