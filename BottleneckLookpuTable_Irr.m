%%%%%This script is the realization of BottleNeck Algorithm
clc;
clear;
%% Initialization
load('R08-E20-T16-0');
load('H_08')
T=16;                                                   %Denotes the clustering size
MaxRun=50;
Min=-2;
Max=2;                                                 % Number of 1's in each row of Matrix H
MaxIter=50;
Eb_N0=2.0;
%%

prob_join_x_t=prob_join_x_t./sum(sum(prob_join_x_t));
lookup_t=LookupTable_Construction(H_Class.check_edge_dis,H_Class.vari_edge_dis,prob_join_x_t,MaxIter,H_Class.dc_max,H_Class.dv_max,T);
[CMapping,VMapping]=lookup_t.Mapping_Construction (MaxRun);
[vari_lt,check_lt]=lookup_t.lt_construction(CMapping,VMapping);
lookup_t.mutual_information_plot(2.0);
lookup_t.LLR_Table();

     