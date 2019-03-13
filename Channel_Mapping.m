function [ Cluster ] = Channel_Mapping( DisCW,MappingTable )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
Cluster=zeros(1,length(DisCW));
for ii=1:length(DisCW)
    Cluster(ii)=find(MappingTable(:,DisCW(ii))==1);
end

end

