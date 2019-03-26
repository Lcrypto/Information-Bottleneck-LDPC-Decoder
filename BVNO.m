function [ Mapping,OptimalCluster2,NProbJoinXT] = BVNO( ProbJoinXT1,ProbJoinXT2,T,MaxRun )
%UNTITLED7 Summary of this function goes here
%   BVNO: Basic Variable Node Operation
Mapping=struct('Combo',zeros(1,size(ProbJoinXT1,2)*size(ProbJoinXT2,2)),...
    'ProbConTT1T2',zeros(T,size(ProbJoinXT1,2)*size(ProbJoinXT2,2)),...
    'NProbJoinXT',zeros(size(ProbJoinXT1,1),size(ProbJoinXT2,2)));
[OldProb,OldComb]= VNProbComb(ProbJoinXT1,ProbJoinXT2);
[T1T2Comb,ProbJointXT1T2,ProbT1T2,~,LLR] = NatureLLROrder(OldComb,OldProb);
[ProbConTT1T2] = LLRMappingTable( LLR,T1T2Comb );
[ProbJoinXT,~,~ ] = XTGenerator( ProbConTT1T2, ProbT1T2,ProbJointXT1T2);
Fixed_ProbJoinXT=Pr_Fix(ProbJoinXT);
[OptimalCluster2] = BottleNeck( Fixed_ProbJoinXT,T,MaxRun,0);
NProbConTT1T2=Remapping(ProbConTT1T2,OptimalCluster2.Partition );
[NProbJoinXT,~,~ ] = XTGenerator( NProbConTT1T2, ProbT1T2,ProbJointXT1T2);
Mapping.Combo=T1T2Comb;
Mapping.ProbConTT1T2=NProbConTT1T2;
%%%%fix prob_join_xt
LLR=LLR_Cal(NProbJoinXT);
if LLR(T/2)==0
    NProbJoinXT(:,T/2:T/2+1)=[10^-7 10^-7;10^-7 10^-7];
end
Mapping.NProbJoinXT=(NProbJoinXT);
subplot(1,2,2);
plot(sum(NProbJoinXT));
pause(0.05);
end

