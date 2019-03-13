function [NProbConTT1T2] = Remapping(ProbConTT1T2,Partition )
%UNTITLED Summary of this function goes here
%   This function is used to construct a final mapping table 
T0=length(Partition);
[~,T1]=size(ProbConTT1T2);
NProbConTT1T2=zeros(T0,T1);
Sum=1;
for ii=1:T0
    NProbConTT1T2(ii,:)=sum(ProbConTT1T2(Sum:Sum+Partition(ii)-1,:),1);
    Sum=Sum+Partition(ii);
end
end

