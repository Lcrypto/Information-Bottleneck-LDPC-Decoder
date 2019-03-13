function [ MT ] = LLRMappingTable( LLR,Combination )
%UNTITLED9 Summary of this function goes here
%   This functions gives a natural mapping table
jj=1;
Partition(jj)=1;
for ii=2:length(LLR)/2
    if LLR(ii)==0           %%Add the condition that LLR is zero
        jj=jj+1;
        Partition(jj)=(length(LLR)/2)-ii+1;
        break;
    elseif(abs(LLR(ii)-LLR(ii-1))<0.00001)
        Partition(jj)=Partition(jj)+1;
    else
        jj=jj+1;
        Partition(jj)=1;
    end
end
MT=zeros(2*length(Partition),size(Combination,1));
Sum=0;
for ii=1:length(Partition)               
    Num=Partition(ii);
    MT(ii,Sum+1:Sum+Num)=ones(1,Num);
    Sum=Sum+Num;
end
for kk=length(Partition)+1:2*length(Partition)
    MT(kk,:)=flip(MT(2*length(Partition)+1-kk,:));
end


