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
data(:,1)=msox2(1:4);
data(:,3)=mcrspr(1:4);
data(:,2)=msox2(5:8);
data(:,4)=mcrspr(5:8);
erdata(:,1)=ssox2(1:4);
erdata(:,3)=scrspr(1:4);
erdata(:,2)=ssox2(5:8);
erdata(:,4)=scrspr(5:8);
barwitherr(erdata,data)
xaxis={'0' '1' '10' '100'};
set(gca,'xtick',1:8,'xticklabel',xaxis)
xlabel('BMP Dose (ng/ml)')
ylabel('Mean fluorescence intensity (a.u)')
legend('SOX2 IF WT ESI','SOX2 IF MiRAGE ESI','SOX2 CRISPR WT ESI','SOX2 CRISPR MiRAGE ESI')