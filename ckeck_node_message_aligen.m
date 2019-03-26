function [ new_Cmapping,pda_join_x_z,t_z_transform ] = ckeck_node_message_aligen( Cmapping,node_distri,T )
%UNTITLED4 Summary of this function goes here
%   check node and message node are message aligen are seperated since the
%   relashionship between mapping and node_distri are different
%   Input:      Cmapping            mapping Matrix
%               Node_distri         check node distribution
%   Output:     New_Campping        mapping after message alignment
%% Find base 
%%This sub section is to find the baed distribution, base distribution will
%%be acted as  pd(x,z) can its message will not be updated 
new_Cmapping=Cmapping;
ave_LLR=zeros(1,length(node_distri));
for ii=1:length(node_distri)
    if(node_distri(ii)~=0)
        match_mapping_index=ii-2;
        ave_LLR(ii)=sum(abs(log2(Cmapping(match_mapping_index).NProbJoinXT(1,:)./Cmapping(match_mapping_index).NProbJoinXT(2,:))))/T;
    end    
end
[~,base_degree]=max(ave_LLR);
t_z_transform=zeros(length(node_distri),T);
t_z_transform(base_degree,:)=1:T;
%% Initialization
pda_join_x_z=Cmapping(base_degree-2).NProbJoinXT;
state_vec=zeros(1,length(node_distri));
state_vec(base_degree)=1;
for ii=1:length(node_distri)
    if(node_distri(ii)~=0&&ii~=base_degree)
        state_vec(ii)=2;     %Update state_vec
        [ pd_join_x_z,t_z_transform(ii,:) ] = message_alignment( Cmapping(ii-2).NProbJoinXT,pda_join_x_z,T);
        [ pda_join_x_z ] = average_update( pd_join_x_z,pda_join_x_z,state_vec,node_distri );    %update Pda(X,Z)
        state_vec(ii)=1;    %%Since it has been aligned, stste is turned into 1
    end    
end
%%%%%%%%%Make sure symmetry
pda_join_x_z(:,T/2+1:end)=rot90(pda_join_x_z(:,1:T/2),2);
pda_join_x_z=pda_join_x_z./sum(sum(pda_join_x_z));

end

