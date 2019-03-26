function [  ProbComb,Combination] = VNProbComb( ProbJoinX1Y1,ProbJoinX2Y2 )
%UNTITLED6 Summary of this function goes here
%   This function is used to the joint probability between X and the
%   Combination of T1 and T2, which is Equation (28) and (29) in the paper 
%   Input:  ProbJoinXY1 ProbJoinXY2
%   Output: Combination of [Y1,Y2] and ProbJoinXY1Y2
 [~,SizeY]=size(ProbJoinX1Y1);
 ProbX=sum(ProbJoinX1Y1,2);
 [X,Y]=meshgrid(1:SizeY,1:SizeY);
 Combination=[X(:) Y(:)];       %Clarification: first row-> Frist Input; Second Row->Secod Input
 ProbComb=zeros(2,SizeY^2);
 for ii=1:size(Combination,1)
     ProbComb(1,ii)=ProbJoinX1Y1(1,Combination(ii,1))*ProbJoinX2Y2(1,Combination(ii,2))/0.5;
     ProbComb(2,ii)=ProbJoinX1Y1(2,Combination(ii,1))*ProbJoinX2Y2(2,Combination(ii,2))/0.5;
 end
  %ProbComb= ProbComb/sum(sum( ProbComb));
end

