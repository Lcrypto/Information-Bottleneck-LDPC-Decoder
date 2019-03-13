function [ NProbConTY ] = RightInsert( OProbConTY,N )
%UNTITLED11 Summary of this function goes here
%   Thisfunction is for Insert The element to the left side of Boundary
%   Input:  OProbConTY  	the old conditional Probability of t given y
%           N               Boundary Index
%   Output: NProbConTY      New conditional Probability of t given y
[SizeOT,~]=size(OProbConTY);
SizeT=SizeOT-2;
NProbConTY=OProbConTY(1:SizeOT-2,:);
NProbConTY(N+1,:)=NProbConTY(N+1,:)+OProbConTY(SizeOT-1,:);
NProbConTY(SizeT-N,:)=NProbConTY(SizeT-N,:)+OProbConTY(SizeOT,:);
end
