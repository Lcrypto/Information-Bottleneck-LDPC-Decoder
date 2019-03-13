%%%Problem 1
clc;
clear;
%%%Problem 2

IterNum=50;
IterNumP=zeros(1,90);
b=1;

for a=0.01:0.01:0.99
    Posterior=[3/7 2/8 (1-a)/a 0.8/0.2 0.8/0.2 0.4/0.6 0.65/0.35];
    [LLRTotal,Flag ]= LDPC_Decoder( Posterior,H,IterNum);
    IterNumP(b)=Flag;
    b=b+1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%