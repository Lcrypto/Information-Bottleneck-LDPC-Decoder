%%test rifs
summ=10;
sub=3;
%count=zeros(1,summ);
iter=10000000;


count=zeros(summ,summ,summ);
%count=zeros(1,size(conbins,1));
for ii=1:iter
    [R]=RIFS(summ,sub);
    count(R(1),R(2),R(3))=count(R(1),R(2),R(3))+1;
end
pos=find(count~=0);
plot(count(pos));