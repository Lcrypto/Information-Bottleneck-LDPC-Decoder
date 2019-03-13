function [ FinalBits ] =IB_bitdiscit_decision( LLRTable, FinalDisOutput,vari_degree)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
FinalBits=zeros(1,length(FinalDisOutput));
for ii=1:length(FinalDisOutput)
    LLR=LLRTable(vari_degree(ii),FinalDisOutput(ii));
    if LLR<0
        FinalBits(ii)=1;
    elseif LLR>0
        FinalBits(ii)=0;
    else
        FinalBits(ii)= binornd(1,0.5);
    end
end

end

