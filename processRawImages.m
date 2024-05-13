function processRawImages(numIms,imageDir)

if ~exist('processedImages')
    mkdir('processedImages');
end

%%

for folder = 1:length(imageDir)
    files = dir([pwd,'/images/',imageDir(folder).name]);
    img = imread([pwd,'/images/',imageDir(folder).name,'/',files(3).name]);
    tmp_img = zeros(size(img,1),size(img,2),size(img,3),length(files)-2);

    for file = 3:length(files)
        tmp_img(:,:,:,file) = imread([pwd,'/images/',imageDir(folder).name,'/',files(file).name]);
    end
    
    out_img = mean(tmp_img,4);out_img = out_img./255;

    save([pwd,'/processedImages/',imageDir(folder).name,'.mat'],'out_img');
    
end









