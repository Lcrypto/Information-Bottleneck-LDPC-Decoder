function [ ProbJoinXY ] = Discretization( Min,Max,Cardi,Sigma2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
Observation=linspace(Min,Max,Cardi);
Delta=(Max-Min)/Cardi;
ProbConY_X_Mean1=(1/(sqrt(2*pi*Sigma2)))*exp(-(Observation-1).^2/(2*Sigma2))*Delta;
ProbConY_X_Mean1(1)=qfunc((1-Min)/sqrt(Sigma2));
ProbConY_X_Mean1(length(ProbConY_X_Mean1))=qfunc((Max-1)/sqrt(Sigma2));

ProbConY_X_MeanO=flip(ProbConY_X_Mean1);
ProbJoinXY=0.5*[ProbConY_X_Mean1;ProbConY_X_MeanO];
ProbJoinXY=ProbJoinXY/sum(sum(ProbJoinXY));
end

