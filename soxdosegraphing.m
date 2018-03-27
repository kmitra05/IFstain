clear all
load('xfpdata.mat')
for i=1:size(xfpdata,2)
    sname=xfpdata(i).sname
    sox2=cell2mat(struct2cell(xfpdata(i).sox2)');
    crspr=cell2mat(struct2cell(xfpdata(i).crispr)');
    msox2(i)=mean(sox2);
    mcrspr(i)=mean(crspr);
    ssox2(i)=std(sox2);
    scrspr(i)=std(crspr);
end
h=errorbar(msox2(1:4),mcrspr(1:4),scrspr(1:4),scrspr(1:4),ssox2(1:4),ssox2(1:4),'*r');
hold on
errorbar(msox2(5:8),mcrspr(5:8),scrspr(5:8),scrspr(5:8),ssox2(5:8),ssox2(5:8),'*b');