function [ LLR ] = LLR_Cal( prob )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
LLR=log2(prob(1,:)./prob(2,:));

end

