clear all
load('xfpdata.mat')
for i=1:size(xfpdata,2)
    sname=xfpdata(i).sname
    if1=cell2mat(struct2cell(xfpdata(i).IF1)');
    if mod(i,3)==0
        mif1(i)=mean(if1);
        sif1(i)=std(if1);
        continue
    end
    if2=cell2mat(struct2cell(xfpdata(i).IF2)');
    mif1(i)=mean(if1);
    mif2(i)=mean(if2);
    sif1(i)=std(if1);
    sif2(i)=std(if2);
end
% pluri(:,1)=msox2(1:4);
% pluri(:,2)=
% pluri(:,3)=
plumarker(:,1)= [mif1(1) mif1(4) mif1(7)];
plumarker(:,2)= [mif2(1) mif2(4) mif2(7)];
plumarker(:,3)= [mif1(2) mif1(5) mif1(8)];
erplu(:,1)=[sif1(1) sif1(4) sif1(7)];
erplu(:,2)=[sif2(1) sif2(4) sif2(7)];
erplu(:,3)=[sif2(2) sif2(5) sif2(8)];
barwitherr(erplu,plumarker)
xaxis={'Fibroblast','ESI017','iPSCs'};
set(gca,'xtick',1:9,'xticklabel',xaxis)
xlabel('Cell type')
ylabel('Mean fluorescence intensity (a.u)')
legend('OCT4','SOX2','NANOG')
figure
fibmarker(:,1)=[mif1(3) mif1(6) mif1(9)];
fibmarker(:,2)=[mif2(2) mif2(5) mif2(8)];
erfib(:,1)=[sif1(3) sif1(6) sif1(9)];
erfib(:,2)=[sif2(2) sif2(5) sif2(8)];
barwitherr(erfib,fibmarker)
xaxis={'Fibroblast','ESI017','iPSCs'};
set(gca,'xtick',1:6,'xticklabel',xaxis)
xlabel('Cell type')
ylabel('Mean fluorescence intensity (a.u)')
legend('VIMENTIN','FSP1')