%%%%%This script is the realization of BottleNeck Algorithm
%clc;
clear;
%% Initialization
%% Initialization
CodeRate=0.5;
T=16;               %Denotes the clustering size
Obsize=2000;        %Observation Size
%%%%%Special for LLR=0
 LLR0_vec=zeros(2,Obsize);
% LLR0_vec(Obsize/2+1)=1;     %due to symmetry
%%%%%%%%%%%%%%%%%%%%%%
Ind=1;
OptimalResult=zeros(8,T);
MaxRun=2000;
Result=zeros(MaxRun,T,8);
OptimalMI=zeros(1,8);
Min=-2;
Max=2;                    
Index=1;
for EbN0=2.4
    sigma2=10^(-0.1*EbN0)/(2*CodeRate);
    %% First We obtain 2000 points between [-2,2]
    Observation=linspace(Min,Max,Obsize);
    %% Calculate corresponding joint Probability
    ProbJoinXY=Discretization( Min,Max,Obsize,sigma2 );
    ChannelCluster(Ind) = BottleNeck( ProbJoinXY,T,150,0 );
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     prob_join_xt=ChannelCluster(Ind).ProbJoinXT;
%     prob_join_xt=[prob_join_xt(:,1:T/2) [10^-7 10^-7;10^-7 10^-7] rot90(prob_join_xt(:,1:T/2),2)];
%     prob_join_xt=prob_join_xt/sum(sum(prob_join_xt));
%     ChannelCluster(Ind).ProbJoinXT=prob_join_xt;
%     %%%%Insert LLR=0---> update corresponding parameters
%     prob_t_given_y=ChannelCluster(Ind).ProbConTY;
%     prob_t_given_y=[prob_t_given_y(1:T/2,:);LLR0_vec;prob_t_given_y(T/2+1:end,:)];
%     ChannelCluster(Ind).ProbConTY=prob_t_given_y;
%     %%%%%fix probT and ProbConXT
%     prob_t=sum(prob_join_xt);
%     prob_x_given_t=prob_join_xt./prob_t;
%     LLR=LLR_Cal(prob_join_xt);
%     ChannelCluster(Ind).ProbT=prob_t;
%     ChannelCluster(Ind).ProbConXT=prob_x_given_t;
%     ChannelCluster(Ind).LLR=LLR;
    %%%%%obtain optimal results%%%%%%%%%%%%%%%%%%%%%%%%%%
    OptimalResult(Ind,:)=ChannelCluster(Ind).Partition;
    Ind=Ind+1;   
end


%% Plot
% Final=OptimalResult;
%  for ii=1:8
%      for jj=2:T                                                                                                                   
%          ParPoint(ii,jj)=0.002*(sum(Final(ii,1:jj-1)))-2;
%      end
%  end
%  Final2=[-2*ones(8,1) ParPoint(:,2:T) 2*ones(8,1)];
%  figure;
%  hold on;
%  y=0.1:0.1:0.8;
%  for ii=1:(T+1)
%      plot((Final2(:,ii)'),y,'-o');
%  end
%  xlabel('Channel Observation');
%  ylabel('\sigma^2_n');
%  grid on;

