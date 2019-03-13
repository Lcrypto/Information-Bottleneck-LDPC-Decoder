function [ ProbComb,Combination ] = CombProb( ProbJoinX1Y1,ProbJoinX2Y2 )
%UNTITLED Summary of this function goes here
%   This function is used to generate the Joint Prob Based on two input
%   joint probabilities


 [~,SizeY]=size(ProbJoinX1Y1);
 [X,Y]=meshgrid(1:SizeY,1:SizeY);
 Combination=[X(:) Y(:)];       %Clarification: first row-> Frist Input; Second Row->Secod Input
 ProbComb=zeros(2,SizeY^2);
 for ii=1:size(Combination,1)
     ProbComb(1,ii)=ProbJoinX1Y1(1,Combination(ii,1))*ProbJoinX2Y2(1,Combination(ii,2))+...
             ProbJoinX1Y1(2,Combination(ii,1))*ProbJoinX2Y2(2,Combination(ii,2));
     ProbComb(2,ii)=ProbJoinX1Y1(1,Combination(ii,1))*ProbJoinX2Y2(2,Combination(ii,2))+...
             ProbJoinX1Y1(2,Combination(ii,1))*ProbJoinX2Y2(1,Combination(ii,2));
 end
%ProbComb=ProbComb/sum(sum(ProbComb));
end


