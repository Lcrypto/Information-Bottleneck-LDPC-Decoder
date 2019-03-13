function [ Divergence ] = KL( a,b )
%UNTITLED Summary of this function goes here
%   This function is used to calculate KL Divergence
Divergence=sum(log2(a./b).*a);


end

