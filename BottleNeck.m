function [ OptimalCluster ] = BottleNeck( ProbJoinXY,T,MaxRun,Flag)
%UNTITLED8 Summary of this function goes here
%   This function gives
%% Initialization
[SizeX,SizeY]=size(ProbJoinXY);
SizeT=T;
Obsize=SizeY;
OptimalCluster=struct('Partition',{zeros(1,SizeT)},'ProbConTY',{zeros(SizeT,SizeY)},...
    'ProbJoinXT',{zeros(SizeX,SizeT)},'ProbConXT',{zeros(SizeX,SizeT)},'ProbT',{(zeros(1,SizeT))},'MI',0,'LLR',zeros(SizeT,1));
ProbY=(ProbJoinXY(1,:)+ProbJoinXY(2,:));
for RunNum=1:MaxRun
    %% Generating the first Random Allocation
    A=[RIFS(Obsize/2-1,T/2-1) 1];
    final_boundary=T/2-2;
    RandomCls=[A fliplr(A)];    %First Random Clustering
    ProbConTY=zeros(T,Obsize);
    Sum=0;
    for ii=1:T                  %This loop is used to generate the prob of T given Y in the first random cluster
        Num=RandomCls(ii);
        ProbConTY(ii,Sum+1:Sum+Num)=ones(1,Num);
        Sum=Sum+Num;
    end
    %% Start BottleNeck Algorithm!
    for ii=1:final_boundary
        %%%%%%%%This subsection is used to subtract the left part of boundary
        while 1
            OProbConTY=ProbConTY;                           %store ProbConTY O:Old
            %%%%TEST
            if sum(sum(ProbConTY))~=size(ProbConTY,2)
                c=1;
            end
            %%%%
            %%%%
            X=sum(ProbConTY,2);
            if X(ii)>1
                EProbConTY=ExtractLeftPoint(ProbConTY,ii);      %Extract the left side of the boundary ii E:Extended
                [EProbJoinXT,EProbT,EProbConXT] = XTGenerator(EProbConTY, ProbY,ProbJoinXY);
                [ProbT0,ProbConXT0,ProbTL,...
                    ProbConXTL,ProbTR,ProbConXTR] = CostPostProb(EProbT, EProbConXT,ii);
                CostL=Cost(ProbT0,ProbTL,ProbConXT0,ProbConXTL);
                CostR=Cost(ProbT0,ProbTR,ProbConXT0,ProbConXTR);
                if CostL>CostR
                    ProbConTY=RightInsert(EProbConTY,ii);
                else
                    ProbConTY=LeftInsert(EProbConTY,ii);
                end                
            end
            Flag=SameOrNot(OProbConTY,ProbConTY);
            if Flag
                break;
            end
        end
        while true
            %%%%TEST
            if sum(sum(ProbConTY))~=size(ProbConTY,2)
                c=1;
            end
            %%%%
            OProbConTY=ProbConTY;                           %store ProbConTY O:Old
            X=sum(ProbConTY,2);
            if X(ii+1)>1
                EProbConTY=ExtractRightPoint(ProbConTY,ii);      %Extract the left side of the boundary E:Extended
                [EProbJoinXT,EProbT,EProbConXT] = XTGenerator( EProbConTY, ProbY,ProbJoinXY);
                [ProbT0,ProbConXT0,ProbTL,...
                    ProbConXTL,ProbTR,ProbConXTR] = CostPostProb( EProbT, EProbConXT,ii);
                CostL=Cost(ProbT0,ProbTL,ProbConXT0,ProbConXTL);
                CostR=Cost(ProbT0,ProbTR,ProbConXT0,ProbConXTR);
                if CostL>CostR
                    ProbConTY=RightInsert(EProbConTY,ii);
                else
                    ProbConTY=LeftInsert(EProbConTY,ii);
                end
            end
            Flag=SameOrNot(OProbConTY,ProbConTY);
            if Flag
                break;
            end
        end
    end

    [ProbJoinXT,ProbT,ProbConXT] = XTGenerator( ProbConTY, ProbY,ProbJoinXY);   
    if(Mutual_Information(ProbJoinXT)>OptimalCluster.MI)
        OptimalCluster.Partition=sum(ProbConTY,2).';
        OptimalCluster.ProbConTY=ProbConTY;
        OptimalCluster.ProbJoinXT=ProbJoinXT;
        OptimalCluster.ProbConXT=ProbConXT;
        OptimalCluster.ProbT=ProbT;
        OptimalCluster.MI=Mutual_Information(ProbJoinXT);
        OptimalCluster.LLR=log(ProbJoinXT(1,:)./ProbJoinXT(2,:));
    end
end
end

