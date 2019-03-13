function [ Flag ] = SameOrNot( A,B )
%UNTITLED13 Summary of this function goes here
%   This function is used to compare if A,B are same or not
%   Output  Flag    1->Same, 0->NotSame
C=sum(sum(abs(A-B)));
if C==0
    Flag=1;
else
    Flag=0;

end

