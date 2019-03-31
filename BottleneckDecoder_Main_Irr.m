%%%%%This script is the realization of BottleNeck Algorithm
clc;
clear;
%% Initialization  H->Lookup Table->Channel Quantization
% load('80211_irr_648_1296');
% load('ChannelCluster_10_to_18');
% load('80211_irr_648_1296_lookuptable_design07');
% load('H_08');
% load('LT-PBRL-R08-E21-T16-0');
% load('R08-E27-T16-0');
%  load('80211_irr_648_1296');
%  load('LT-80211-R05-E07-T18-1');
%  load('R05-E0118-T18-1');
load('H_20433484');
load('LT-PBRL-R05-E127-T16-0');
load('ChannelCluster0to4');


%%%BE CAREFUL!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T=16;                                                               %Denotes the clustering size
Min=-2;
Max=2;
MaxIter=50;
%% LDPC Part
CWLength = H_Class.n;                                               % Number of bits in the code word
CheckNum = H_Class.k;                                               % Number of information bits in the code word
CodeRate=H_Class.CodeRate;
%%%% Construct Final LLR Table

%%
Index=1;
for Eb_N0=0:0.5:4 
    %ProbConTY=ChannelCluster0to4(Index).ProbConTY ;
    %LLR_table=ChannelCluster(Index).LLR ;
    if Eb_N0<=0.5
        runtime=100;
    elseif Eb_N0<=2
        runtime=1000;
    else
        runtime=10000;
    end
    errnum=zeros(3,runtime);
    %% continuous Message Passing
    bp_decoder=BP_method(H_Class.H,H_Class.vari_table,H_Class.vari_degree,H_Class.check_table,H_Class.check_degree,MaxIter,CWLength,H_Class.p_flag,H_Class.p_bits);
    [ber_cBP(Index),fer_cBP(Index)]=bp_decoder.continuous_BP(Eb_N0,runtime,CodeRate);
    %% Discrete Message Passing Algorithm
%     ib_decoder=Lookup_Table_Method(lookup_t.check_lt,lookup_t.vari_lt,MaxIter,lookup_t.LLRTable,H_Class.H,lookup_t.vari_node_transform,...
%                                     lookup_t.check_node_transform,H_Class.dc_max,H_Class.dv_max,H_Class.p_flag,H_Class.p_bits,T,lookup_t.p_vari_lt);
%     ib_decoder.Parity_check_matrix_analysis();
%     [ber_IB(Index),fer_IB(Index)]=ib_decoder.Simulation(Eb_N0,runtime,Max,Min,ProbConTY,CodeRate);
    %% Discrete Message Passing   
%     bp_dis_decoder=BP_method(H,VariTable,vari_degree,CheckTable,check_degree,MaxIter,CWLength);
%     [ber3,fer3]=bp_dis_decoder.quatize_BP(Eb_N0,runtime,CodeRate,Max,Min,Obsize,ProbConTY,LLR_table);
    %%
    Index=Index+1;
end
