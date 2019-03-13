function [ FinalBits ] = bottleneck_decoder( QuanChan,CheckTable,VariTable,MaxIter,CMapping,VMapping,VProbJoinXT1,Dc,Dv)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
CWLength = size(VariTable,1);                                             % Number of bits in the code word
InfoLength = size(CheckTable,1);                                           % Number of information bits in the code word
CheckNum=CWLength-InfoLength;                               % Number of Check Nodes
FinalDisOutput=zeros(1,CWLength);
MessageTable=struct('Msg',zeros(CWLength-InfoLength,CWLength));
FirstV2CTable=zeros(CheckNum,CWLength);
for ii=1:CWLength
    FirstV2CTable(:,ii)=ones(CWLength-InfoLength,1)*(QuanChan(ii));
end
C2VTable(1:MaxIter)=MessageTable;
V2CTable(1:MaxIter)=MessageTable;
for ss=1:MaxIter
    %% c->v
    for ii =1:CheckNum                  %%Note: ii is the index of check node
        VnodesC=CheckTable(ii,:);       %%Obtain the varaible node connected by ii
        for jj=1:Dc
            VarNode=VnodesC(jj);        %%Variable Node connected by C
            Neighbors=VnodesC;
            Neighbors(jj)=[];           %% delete itself
            if ss==1                    %% obtain input msgs
                Neighbor_Cluster=ObtainInput( FirstV2CTable(ii,:),Neighbors );
            else
                Neighbor_Cluster=ObtainInput( V2CTable(ss-1).Msg(ii,:),Neighbors );
            end
            C2VTable(ss).Msg(ii,VarNode)=Trace( Neighbor_Cluster, CMapping(ss,:) );
        end
    end
    %% v->c
    if ss~=MaxIter
        for ii =1:CWLength
            CNodesV=VariTable(ii,:);
            for jj=1:Dv
                CheNode=CNodesV(jj);
                Neighbors=CNodesV;
                Neighbors(jj)=[];
                %Neighbors=[Neighbors CheNode];
                Neighbor_Cluster=ObtainInput( C2VTable(ss).Msg(:,ii).',Neighbors );
                V2CTable(ss).Msg(CheNode,ii)=Trace([QuanChan(ii) Neighbor_Cluster],VMapping(ss,1:Dv-1));
            end
        end
        FirstV2CTable=V2CTable(ss).Msg;
    else
        for ii =1:CWLength
            CNodesV=VariTable(ii,:);
            Neighbor_Cluster=ObtainInput( C2VTable(ss).Msg(:,ii).',CNodesV );
            FinalDisOutput(ii)=Trace([QuanChan(ii) Neighbor_Cluster],VMapping(ss,:));
        end
    end
end
% LLR And Final Decision
LLRTable=log(VProbJoinXT1(1,:)./VProbJoinXT1(2,:));       %Obtain Final LLRTable  >0->0, <0->1, ==0->Not sure
FinalBits=zeros(1,CWLength);
for ii=1:CWLength
    LLR=LLRTable(FinalDisOutput(ii));
    if LLR<0
        FinalBits(ii)=1;
    elseif LLR>0
        FinalBits(ii)=0;
    else
        FinalBits(ii)= binornd(1,0.5);
    end
end
end

