clear all
load('xfpdata.mat')
for i=1:size(xfpdata,2)
    sname=xfpdata(i).sname
    sox2=cell2mat(struct2cell(xfpdata(i).sox2)');
    crspr=cell2mat(struct2cell(xfpdata(i).crispr)');
    msox2(i)=mean(sox2);
    mcrspr(i)=mean(crspr);
    ssox2(i)=std(sox2)/sqrt(length(sox2));
    scrspr(i)=std(crspr)/sqrt(length(crspr));
end
data(:,1)=[msox2(1) msox2(5)];
data(:,2)=[msox2(2) msox2(6)];
data(:,3)=[msox2(3) msox2(7)];
data(:,4)=[msox2(4) msox2(8)];
erdata(:,1)=[ssox2(1) ssox2(5)];
erdata(:,2)=[ssox2(2) ssox2(6)];
erdata(:,3)=[ssox2(3) ssox2(7)];
erdata(:,4)=[ssox2(4) ssox2(8)];
figure
barwitherr(erdata,data)
xaxis={'SOX2 IF WT ESI' 'SOX2 IF MiRAGE ESI'};
set(gca,'xtick',1:4,'xticklabel',xaxis)
xlabel('BMP Dose (ng/ml)')
ylabel('Mean fluorescence intensity (a.u)')
legend('0','1','10','100')
clear data erdata
data(:,1)=[mcrspr(1) mcrspr(5)];
data(:,2)=[mcrspr(2) mcrspr(6)];
data(:,3)=[ mcrspr(3) mcrspr(7)];
data(:,4)=[ mcrspr(4) mcrspr(8)];
erdata(:,1)=[scrspr(1) scrspr(5)];
erdata(:,2)=[scrspr(2) scrspr(6)];
erdata(:,3)=[scrspr(3) scrspr(7)];
erdata(:,4)=[scrspr(4) scrspr(8)];
figure
barwitherr(erdata,data)
xaxis={'SOX2 RFP WT ESI' 'SOX2 RFP MiRAGE ESI'};
set(gca,'xtick',1:4,'xticklabel',xaxis)
xlabel('BMP Dose (ng/ml)')
ylabel('Mean fluorescence intensity (a.u)')
legend('0','1','10','100')