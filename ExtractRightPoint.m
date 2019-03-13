function [ NProb ] = ExtractRightPoint( ProbConTY,N )
%   UNTITLED7 Summary of this function goes here
%   This function generates a new TransferProbability With T+2 size;
%   Idea is to invint two new t,find the boundary we need
%   And Extract the rightside as an new set
%   N: the number of boundary;
%   ProbConTY:  the probability distribution Table of T given Y
NProb=ProbConTY;
[SizeT,SizeY]=size(ProbConTY);
New=zeros(SizeY,1);
Cluster=sum(ProbConTY,2).';
A=sum(Cluster(1:N));
NProb(N+1,A+1)=0;
New(A+1)=1;
NProb(SizeT+1,:)=New;
if SizeY-A<=0
    c=1
end
New(A+1)=0;
New(SizeY-A)=1;
NProb(SizeT-N,SizeY-A)=0;
NProb(SizeT+2,:)=New;
end