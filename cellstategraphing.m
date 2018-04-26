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
    sif1(i)=std(if1)/sqrt(length(if1));
    sif2(i)=std(if2)/sqrt(length(if2));
end
% pluri(:,1)=msox2(1:4);
% pluri(:,2)=
% pluri(:,3)=
plumarker(:,1)= [mif1(1) mif1(4) mif1(7)];
plumarker(:,2)= [mif2(1) mif2(4) mif2(7)];
plumarker(:,3)= [mif1(2) mif1(5) mif1(8)];
plumarker(:,4)=[mif2(2) mif2(5) mif2(8)];
erplu(:,1)=[sif1(1) sif1(4) sif1(7)];
erplu(:,2)=[sif2(1) sif2(4) sif2(7)];
erplu(:,3)=[sif2(2) sif2(5) sif2(8)];
erplu(:,4)=[sif2(2) sif2(5) sif2(8)];
plumarker=plumarker';
erplu=erplu';
figure
barwitherr(erplu,plumarker)
xaxis={'OCT4','SOX2','NANOG','VIMENTIN'};
set(gca,'xtick',1:12,'xticklabel',xaxis)
xlabel('Cell type')
ylabel('Mean fluorescence intensity (a.u)')
legend('Fibroblast','ESI017','iPSCs')

% fibmarker(:,1)=[mif1(3) mif1(6) mif1(9)];
% 
% erfib(:,1)=[sif1(3) sif1(6) sif1(9)];
% 
% barwitherr(erfib,fibmarker)
% xaxis={'Fibroblast','ESI017','iPSCs'};
% set(gca,'xtick',1:6,'xticklabel',xaxis)
% xlabel('Cell type')
% ylabel('Mean fluorescence intensity (a.u)')
% legend('FSP1','VIMENTIN')