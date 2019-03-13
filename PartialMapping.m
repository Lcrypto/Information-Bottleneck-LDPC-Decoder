function [ Cluster ] = PartialMapping( FirNum,SecNum,Combination,MappingTable )
%Function Description:
%   Gievn Combination Numer and their lists, output the cluster the
%   combination belongs to
%In&Output
%   Input:  [FirNum,SecNum]             The Combination of First and Second
%                                       Nnumber
%           Combination:                COmbination List
%           Mapping Table:              Using Mapping table we find which
%                                       cluster the mapping table belongs to
%   Output: Cluster                     The output cluster

 Position=find(sum(abs(Combination-[FirNum SecNum]),2)==0);
% num_comb=size(Combination,1);
% Position=1;
% for ii=1:num_comb
%     if(Combination(ii,:)==[FirNum SecNum])
%         Position=ii;
%         break;
%     end
% end
Cluster=find(MappingTable(:,Position)==1);




end

