function [ ave_prob,channel_at,check_at,np_at,p_at ] = variable_message_align_table( channel_prob,check_prob,theta_0,np_vmapping,theta_np,p_vmapping,theta_p,T )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%%Construct State Table 
%%0->cahnnel 1->np_vmapping 2->p_vmapping
%%second column:    number of input messages 
%%thirt column:     distribution
if theta_0~=0
    len_t0=1;
else
    len_t0=0;
end
degree_tnp=find(theta_np);
len_tnp=length(degree_tnp);
degree_tp=find(theta_p);
len_tp=length(degree_tp);
total_len=len_t0+len_tp+len_tnp;
state=zeros(total_len,3);
state(1:len_t0,1)=0;
state(1:len_t0,3)=theta_0;
state(len_t0+1:len_t0+len_tnp,1)=1;
state(len_t0+1:len_t0+len_tnp,2)=degree_tnp;
state(len_t0+1:len_t0+len_tnp,3)=theta_np(degree_tnp);
state(len_t0+1+len_tnp:end,1)=2;
state(len_t0+1+len_tnp:end,2)=degree_tp;
state(len_t0+1+len_tnp:end,3)=theta_p(degree_tp);
%%%%%%%Construct big PMF
joint_prob=zeros(2,T*total_len);
for ii=1:total_len
    %%fetch prob
    switch state(ii,1)
        case 0
            cur_prob=theta_0*channel_prob;
        case 1
            %%here degree means valid incoming messages
            %%if the node is nor punctured the and there are ii incoming
            %%messages, there will be ii operations, the output shoule be
            %%ii^{th} 
            if sum(sum(np_vmapping(state(ii,2)).NProbJoinXT))~=1
                a=1;
            end
            cur_prob=state(ii,3)*np_vmapping(state(ii,2)).NProbJoinXT;
        case 2
            %%in this case, no channel input,if there are ii input messages
            %%the output will be the j.p.d of ii-1 node operation, specially
            %%if ii=1, then input shuld be channel input
            cur_deg=state(ii,2);
            if cur_deg==1
                cur_prob=state(ii,3)*check_prob;
            else
                if sum(sum(p_vmapping(state(ii,2)-1).NProbJoinXT))~=1
                    a=1;
                end
                cur_prob=state(ii,3)*p_vmapping(state(ii,2)-1).NProbJoinXT;
            end
    end
    joint_prob(:,(ii-1)*T+1:ii*T)=cur_prob;                
end
%%%LLR order
LLR=LLR_Cal(joint_prob);
[~,new_order]=sort(LLR,'ascend');
new_joint_prob=joint_prob(:,new_order);
%%%Go through IB
%% go information bottleneck
[ OptimalCluster2] = BottleNeck( new_joint_prob,T,50,0);
%% output something
pda_join_x_z=OptimalCluster2.ProbJoinXT;
ave_prob=pda_join_x_z./sum(sum(pda_join_x_z));
mapping_matrix=OptimalCluster2.ProbConTY;
%% Final !
channel_at=zeros(1,T);
check_at=zeros(1,T);
np_at=zeros(length(theta_p),T);
p_at=zeros(legth(theta_np),T);
for index=1:length(new_order)
    %%%here val and rem are indeces!
    val=new_order(index);
    rem_m=rem(val,T);
    if rem_m==0
        state_ind=degrees(val/T);
        cur_index=T;
    else
        cur_index=rem_m;
        state_ind=degrees((val-rem_m)/T+1);
    end
    cur_des=state(state_ind,1);
    cur_deg=state(state_ind,2);
    switch cur_des
        case 0
            channel_at(cur_index)=find(mapping_matrix(:,index));
        case 1
            np_at(cur_deg,cur_index)=find(mapping_matrix(:,index));
        case 2
            if cur_deg==1
                check_at(cur_index)=find(mapping_matrix(:,index));   
            else
                p_at(cur_deg-1,cur_index)=find(mapping_matrix(:,index));
            end
    end    
end

end

