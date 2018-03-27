clear all
mkdir voronoi
mpath=fullfile(pwd,'masks');
impath=fullfile(pwd,'Raw');
imdir=dir('Raw');
mdir=dir('masks');
for p = 1:numel(dir('Ilastik'))-3% don't need to skip the first one
    imfn = imdir(p+2).name;
    mfn = mdir(p+2).name;
    imfile = [impath,filesep,imfn];
    mfile = [mpath,filesep,mfn];
    info2 = imfinfo(imfile);
    imageStack = [];
    numberOfImages = length(info2);
    s=strel('diamond',10);
    for k = 1:numberOfImages
        currentImage = imread(imfile, k, 'Info', info2);
        dampImg=imopen(currentImage,s);
        currentImage=imsubtract(currentImage, dampImg);
        imageStack(:,:,k) = currentImage;
    end
    mask=imread(mfile);
    k=whos('mask');
    [voronoi, centers] = voronoiPolygon(mask,k.size(1),k.size(2));
    new_mask = voronoiMaskIntersection(voronoi, mask);
    imshow(new_mask);
    cc3 = bwconncomp(new_mask);
    if strcmp(string(imdir(p+2).name),'A.tif') | strcmp(string(imdir(p+2).name),'B.tif')...
            |strcmp(string(imdir(p+2).name),'C.tif')
        cc3 = bwconncomp(new_mask);
    else
        cc3 = mask;
    end
    imwrite(new_mask,fullfile(pwd,'voronoi',imdir(p+2).name))
    xfpdata(p).sname = imdir(p+2).name;
    xfpdata(p).dapi = regionprops(mask,imageStack(:,:,1),'MeanIntensity');
    switch imdir(p+2).name
        case {'A.tif','D.tif','G.tif'}
            xfpdata(p).IF1 = regionprops(mask,imageStack(:,:,2),'MeanIntensity');
            xfpdata(p).IF2 = regionprops(mask, imageStack(:,:,3), 'MeanIntensity');
        case {'B.tif','E.tif','H.tif'}
            xfpdata(p).IF1 = regionprops(mask,imageStack(:,:,2),'MeanIntensity');
            xfpdata(p).IF2 = regionprops(cc3, imageStack(:,:,3), 'MeanIntensity');
        case {'C.tif','F.tif','I.tif'}
            xfpdata(p).IF1 = regionprops(cc3,imageStack(:,:,2),'MeanIntensity');
            xfpdata(p).IF2 = 0;
    end
end
save('xfpdata','xfpdata');
