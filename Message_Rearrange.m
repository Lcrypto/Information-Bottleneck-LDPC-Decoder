function [ pda_join_x_z,t_z_transform  ] = Message_Rearrange( mapping,channel_dist,node_distri,T,flag )
%UNTITLED4 Summary of this function goes here
%   This function rearrange messges for the next input
%   Input:      mapping            	mapping structure
%               Node_distri         node distribution
%               channel_dist        channel messsage information
%               T                   cardinality of squantized size 
%               flag                1->check node ; 0->variable node
%   Output:     pda_join_x_z        output average distribution
%               t_z_transform       transform matrix
%% Find distribution
degrees=find(node_distri);
degree_distri=node_distri(degrees);
%% Fetch p(x,t)
degree_len=length(degrees);
joint_distr_set=zeros(2,T*degree_len);
if flag==1
    %%check node part
    for index=1:length(degrees)
        joint_distr_set(:,(index-1)*T+1:index*T)=degree_distri(index)*mapping(degrees(index)-2).NProbJoinXT;
    end
else
    %%variable node part
    for index=1:length(degrees)
        if degrees(index)==1
             joint_distr_set(:,(index-1)*T+1:index*T)=degree_distri(index)*channel_dist;
        else
             joint_distr_set(:,(index-1)*T+1:index*T)=degree_distri(index)*mapping(degrees(index)-1).NProbJoinXT;
        end
    end    
end
%% rearrange join_dist_set
LLR=LLR_Cal(joint_distr_set);
[~,new_order]=sort(LLR,'ascend');
new_joint_distri_set=joint_distr_set(:,new_order);
%% go information bottleneck
[ OptimalCluster2] = BottleNeck( new_joint_distri_set,T,50,0);
%% output something
pda_join_x_z=OptimalCluster2.ProbJoinXT;
pda_join_x_z=pda_join_x_z./sum(sum(pda_join_x_z));
mapping_matrix=OptimalCluster2.ProbConTY;
%% fianl mapping
t_z_transform=zeros(length(node_distri),T);
for index=1:length(new_order)
    val=new_order(index);
    rem_m=rem(val,T);
    if rem_m==0
        cur_deg=degrees(val/T);
        cur_index=T;
    else
        cur_index=rem_m;
        cur_deg=degrees((val-rem_m)/T+1);
    end
    t_z_transform(cur_deg,cur_index)=find(mapping_matrix(:,index));
end



end



