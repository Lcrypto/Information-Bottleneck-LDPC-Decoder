function [ Output ] = TanT( Input )
%UNTITLED6 Summary of this function goes here
% This function is used to calculate tanh function in MPA

Output=2*atanh(prod(tanh(0.5*Input)));



end

