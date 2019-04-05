%clear;
%load('H_08.mat');
punc_rate_ch=1/17;
iter_num=50;
evo_08=Variable_Distribution_Evolution(punc_rate_ch,H_Class.vari_edge_dis,H_Class.check_edge_dis);
evo_08.dis_evolution(iter_num);
evo_08.Plot_Analyzer();