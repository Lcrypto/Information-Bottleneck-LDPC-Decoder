function [ NewCombination,NewProbJointCombo,NewProbComb,NewProbConComb,LLR] = NatureLLROrder(Combination,ProbJointComb )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[SizeX,SizeY]=size(ProbJointComb);
ProbComb=sum(ProbJointComb,1);
ProbConComb=ProbJointComb./repmat(ProbComb,2,1);     %%Pr(X|T1T2)
LLR=log(ProbConComb(1,:)./ProbConComb(2,:));         %%0/1
[~,Order]=sort(LLR,'ascend');
%% Initialization
NewCombination=zeros(SizeY,2);
NewProbJointCombo=zeros(SizeX,SizeY);
for ii=1:SizeY
    NewCombination(ii,:)=Combination(Order(ii),:);
    NewProbJointCombo(:,ii)=ProbJointComb(:,Order(ii));
end
NewProbComb=sum(NewProbJointCombo,1);
NewProbConComb=NewProbJointCombo./repmat(NewProbComb,2,1);
LLR=log(NewProbConComb(1,:)./NewProbConComb(2,:));         %%0/1

