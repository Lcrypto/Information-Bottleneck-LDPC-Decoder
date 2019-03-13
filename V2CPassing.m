function [ Msg ] = V2CPassing(Neighbors,MsgC2V,j,Postj)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
A1=Neighbors;     %%find all check nodes connected to variable node j
          %%Delete check node i
          
l_A1=length(A1);
%X=[];
X=zeros(1,l_A1);
for ii=1:l_A1
    X(ii)=MsgC2V(A1(ii),j);
end
Msg=sum(X)+Postj;


end

