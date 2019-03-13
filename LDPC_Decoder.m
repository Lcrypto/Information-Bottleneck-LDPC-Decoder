function [ FinalBits] = LDPC_Decoder(H, Posterior,VariTable,vari_degree,CheckTable,check_degree,IterNum,trans_bits)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%% Initialization
[CNum,~]=size(CheckTable);
[VNum,~]=size(VariTable);
MsgC2V=zeros(CNum,VNum);        %Initialize the message from CN to VN;
MsgV2C=zeros(CNum,VNum);        %Initialize the message from VN to CN;
LLRTotal=zeros(VNum);        %Initialize the LLR matrix;
PostLLR=Posterior;              %convert posteriors to log form
%% Initialize MsgV2C
for ii=1:CNum           %%ii denotes row
    for jj=1:VNum       %%jj denotes colums
        if (H(ii,jj)~=0)
            MsgV2C(ii,jj)=PostLLR(jj);
        end
    end
end
%% Start Iteration
for hh=1:IterNum
    %% CN->VN Message Passing
    for ii =1:CNum                  %%Note: ii is the index of check node
        Dc=check_degree(ii);
        VnodesC=CheckTable(ii,1:Dc);       %%Obtain the varaible node connected by ii        
        for jj=1:Dc
            VarNode=VnodesC(jj);        %%Variable Node connected by C
            Neighbors=VnodesC;
            Neighbors(jj)=[];           %% delete itself
            MsgC2V(ii,VarNode)=C2VPassing(Neighbors,MsgV2C,ii);
        end
    end
    %% VN->CN Message Passing
    %% v->c 
        for ii =1:VNum
            Dv=vari_degree(ii);
            CNodesV=VariTable(ii,1:Dv);
            for jj=1:Dv
                CheNode=CNodesV(jj);
                Neighbors=CNodesV;
                Neighbors(jj)=[];
                MsgV2C(CheNode,ii)=V2CPassing(Neighbors,MsgC2V,ii,PostLLR(ii));
            end
        end       
%% Calculate LLR in this time
for jj=1:VNum
    LLRTotal(jj)=PostLLR(jj)+sum(MsgC2V(:,jj));
end
%% Bit Dicision
FinalBits=zeros(1,VNum);
for ii=1:VNum
    LLR=LLRTotal(ii);
    if LLR<0
        FinalBits(ii)=1;
    elseif LLR>0
        FinalBits(ii)=0;
    else
        FinalBits(ii)= binornd(1,0.5);
    end
end

end

