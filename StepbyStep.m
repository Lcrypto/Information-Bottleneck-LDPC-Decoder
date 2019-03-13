%% Step By Step!
clear;
clc;
ProbJoinXY=[[ 0.00036828  0.09566251]
 [ 0.00158166  0.0852265 ]
 [ 0.00333924  0.0694563 ]
 [ 0.0055234   0.0558629 ]
 [ 0.0079999   0.04441159]
 [ 0.01089686  0.03564975]
 [ 0.01420443  0.02853888]
 [ 0.0182673   0.02301051]
 [ 0.02301051  0.0182673 ]
 [ 0.02853888  0.01420443]
 [ 0.03564975  0.01089686]
 [ 0.04441159  0.0079999 ]
 [ 0.0558629   0.0055234 ]
 [ 0.0694563   0.00333924]
 [ 0.0852265   0.00158166]
 [ 0.09566251  0.00036828]].';
prompt = '_x_lminus1_c_and_t_lminus1_c';
Prob1 = input(prompt);
prompt='p_b_lplus1_c_and_y_lplus1_c';
Prob2 = input(prompt);
prompt='1---Check Node 2---Variable Node';
Flag=prompt;
Dc=6;Dv=3;
S=1;
    CProbJoinXT1=Prob1.';
    CProbJoinXT2=Prob2.';
    for ii=1:Dc-2
        [CMapping(S,ii),CCluster(S,ii),CProbJoinXT1] = BCNO( CProbJoinXT1,CProbJoinXT2,16,50);
    end    
    VProbJoinXT1=ProbJoinXY;
    for jj=1:Dv-1
        [VMapping(S,jj),Vluster(S,jj),VProbJoinXT1] = BVNO( VProbJoinXT1,CProbJoinXT1,16,50);
    end
    Mutual_Information(VProbJoinXT1)