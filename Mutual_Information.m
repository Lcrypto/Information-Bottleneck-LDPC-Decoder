function [ MuInfo ] = Mutual_Information( ProbJoinXY )
%UNTITLED17 Summary of this function goes here
%   This Function is used to calculate the mutual information between X and
%   Y
[SizeX,SizeY]=size(ProbJoinXY);
ProbX=sum(ProbJoinXY,2).';
ProbY=sum(ProbJoinXY,1);
MuInfo_Ma=zeros(SizeX,SizeY);
for ii=1:SizeX
    for jj=1:SizeY
        MuInfo_Ma(ii,jj)=ProbJoinXY(ii,jj)*log2(ProbJoinXY(ii,jj)/(ProbX(ii)*ProbY(jj)));
    end
end
MuInfo=sum(sum(MuInfo_Ma));
end

