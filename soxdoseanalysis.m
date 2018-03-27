clear all
mkdir voronoi
mpath=fullfile(pwd,'masks');
impath=fullfile(pwd,'Raw');
imdir=dir('Raw');
mdir=dir('masks');
for p = 1:numel(dir('Ilastik'))-2% don't need to skip the first one
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
    imwrite(new_mask,fullfile(pwd,'voronoi',imdir(p+2).name))
    xfpdata(p).sname = imdir(p+2).name;
    xfpdata(p).dapi = regionprops(mask,imageStack(:,:,1),'MeanIntensity');
    xfpdata(p).sox2 = regionprops(mask,imageStack(:,:,2),'MeanIntensity');
    xfpdata(p).crispr = regionprops(cc3, imageStack(:,:,3), 'MeanIntensity');
end
save('xfpdata','xfpdata');
