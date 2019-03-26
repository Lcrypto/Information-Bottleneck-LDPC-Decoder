%%%%%This script is the realization of BottleNeck Algorithm
clc;
clear;
%% Initialization
load('R08-E20-T16-0');
load('H_08');
load('DISEVO_08');
T=16;                                                   %Denotes the clustering size
MaxRun=30;
Min=-2;
Max=2;                                                 % Number of 1's in each row of Matrix H
MaxIter=50;
Eb_N0=2.0;
puncrate_c=1/11;
%%

prob_join_x_t=prob_join_x_t./sum(sum(prob_join_x_t));
lookup_t=LookupTable_Construction(evo_08.c_output_dist_evo,evo_08.v_output_dist_evo,prob_join_x_t,MaxIter,H_Class.dc_max,H_Class.dv_max,T,puncrate_c);
[CMapping,VMapping]=lookup_t.Mapping_Construction (MaxRun);
[vari_lt,check_lt]=lookup_t.lt_construction(CMapping,VMapping);
lookup_t.mutual_information_plot(2.0);
lookup_t.LLR_Table();

     