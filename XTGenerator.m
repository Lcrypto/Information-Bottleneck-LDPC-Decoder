function [ ProbJoinXT,ProbT,ProbConXT ] = XTGenerator( ProbConTY, ProbY,ProbJoinXY)
%UNTITLED9 Summary of this function goes here
%   This function use the information of ProbConTY, ProbY,ProbJoinXY
%   give the infotmation bewteen X(InfoBits) and T(Unsigned IntegerBits)
%   Input:  ProbConTY, ProbY,ProbJoinXY
%   Output: ProbJoinXT,ProbT,ProbXT
%% Initialization
[SizeT,~]=size(ProbConTY);
[SizeX,~]=size(ProbJoinXY);
ProbJoinXT=zeros(SizeX,SizeT);
ProbT=zeros(1,SizeT);
%%
for ii=1:SizeT
    A=ProbConTY(ii,:);
    ProbT(ii)=sum(ProbConTY(ii,:).*ProbY);
    B=repmat(A,SizeX,1);
    ProbJoinXT(:,ii)=sum(B.*ProbJoinXY,2);    
    ProbConXT=ProbJoinXT./(repmat(ProbT,SizeX,1));
end
ProbJoinXT=ProbJoinXT/sum(sum(ProbJoinXT));
if(sum(sum(ProbJoinXT))-1>10^-8)
    c=1
end

