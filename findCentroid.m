function cloc = findCentroid(img)
    cloc = zeros(size(img,1),1);
    for y = 1:size(img,1)
        for x = 1:size(img,2)
                cloc(y) = cloc(y) + x.*img(y,x);
        end
        cloc(y) = cloc(y)./sum(img(y,:));
    end
    cloc = cloc -0.5;
end