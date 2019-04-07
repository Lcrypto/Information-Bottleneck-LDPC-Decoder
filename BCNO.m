function [Mapping,OptimalCluster2,NProbJoinXT] = BCNO( ProbJoinXT1,ProbJoinXT2,T,MaxRun)
%UNTITLED4 Summary of this function goes here
%  BCO:Basic Check Node Operation
Mapping=struct('Combo',zeros(1,size(ProbJoinXT1,2)*size(ProbJoinXT2,2)),...
    'ProbConTT1T2',zeros(T,size(ProbJoinXT1,2)*size(ProbJoinXT2,2)),...
    'NProbJoinXT',zeros(size(ProbJoinXT1,1),size(ProbJoinXT2,2)));
[OldProb,OldComb]=CombProb(ProbJoinXT1,ProbJoinXT2);
[ T1T2Comb,ProbJointXT1T2,ProbT1T2,...
    ~,LLR] = NatureLLROrder(OldComb,OldProb);
[ProbConTT1T2] = LLRMappingTable( LLR,T1T2Comb );
[ProbJoinXT,~,~ ] = XTGenerator( ProbConTT1T2, ProbT1T2,ProbJointXT1T2);
ProbJoinXT=Pr_Fix(ProbJoinXT);
[ OptimalCluster2] = BottleNeck( ProbJoinXT,T,MaxRun,0);
NProbConTT1T2=Remapping(ProbConTT1T2,OptimalCluster2.Partition );
[NProbJoinXT,~,~ ] = XTGenerator( NProbConTT1T2, ProbT1T2,ProbJointXT1T2);
Mapping.Combo=T1T2Comb;
Mapping.ProbConTT1T2=NProbConTT1T2;
Mapping.NProbJoinXT=NProbJoinXT;
Mapping.MI=Mutual_Information(NProbJoinXT);
% subplot(1,2,1);
% plot(sum(NProbJoinXT));
% pause(0.01);
end

 