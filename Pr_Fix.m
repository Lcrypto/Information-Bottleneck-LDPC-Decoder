function [ New_Prob ] = Pr_Fix( Old_Prob )
%UNTITLED Summary of this function goes here
%   This function is used to make data more stable
New_Prob=Old_Prob;
[SizeX,SizeY]=size(Old_Prob);
for ii=1:SizeX
    for jj=1:SizeY
        if(New_Prob(ii,jj)<=10^(-15))
            New_Prob(ii,jj)=10^(-15);
        elseif New_Prob(ii,jj)>=0.5-10^(-15)
            New_Prob(ii,jj)=0.5-10^(-15);
        end
    end
end
New_Prob=New_Prob/sum(sum(New_Prob));


end

