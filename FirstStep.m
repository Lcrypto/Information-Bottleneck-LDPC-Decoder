% This function is uesed to test each sub-step of the whole procedure
[OldProb,OldComb]=CombProb(OptimalCluster.ProbJoinXT,OptimalCluster.ProbJoinXT);
[ T1T2Comb,ProbJointXT1T2,ProbT1T2,...
    ProbConXT1T2,LLR] = NatureLLROrder(OldComb,OldProb);
[ProbConTT1T2] = LLRMappingTable( LLR,T1T2Comb );
[ProbJoinXT,ProbT,ProbConXT ] = XTGenerator( ProbConTT1T2, ProbT1T2,ProbJointXT1T2);
[ OptimalCluster2] = BottleNeck( ProbJoinXT,4,500 );
Remapping(ProbConTT1T2,OptimalCluster2.Partition )
[X,Y]=BCNO(OptimalCluster.ProbJoinXT,OptimalCluster.ProbJoinXT,4,500);