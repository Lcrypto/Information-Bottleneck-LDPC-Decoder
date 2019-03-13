function [ MsgofNeighbors] = ObtainInput( ClusterTable,Neighbors )
%UNTITLED9 Summary of this function goes here
%   This Function is used to output msgs needed for the next input
len=length(Neighbors);
MsgofNeighbors=zeros(1,len);
for ii=1:length(Neighbors)
    MsgofNeighbors(ii)=ClusterTable(Neighbors(ii));
end
end

