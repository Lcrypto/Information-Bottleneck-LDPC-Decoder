function [ new_Vmapping,pda_join_x_z,t_z_transform  ] = vari_node_message_aligen( Vmapping,node_distri,T )
%UNTITLED4 Summary of this function goes here
%   check node and message node are message aligen are seperated since the
%   relashionship between mapping and node_distri are different
%   Input:      Cmapping            mapping Matrix
%               Node_distri         check node distribution
%   Output:     New_Campping        mapping after message alignment
%% Find base
%%This sub section is to find the baed distribution, base distribution will
%%be acted as  pd(x,z) can its message will not be updated
new_Vmapping=Vmapping;
ave_LLR=zeros(1,length(node_distri));
for ii=1:length(node_distri)
    if(node_distri(ii)~=0)
        match_mapping_index=ii-1;
        ave_LLR(ii)=sum(abs(log2(Vmapping(match_mapping_index).NProbJoinXT(1,:)./Vmapping(match_mapping_index).NProbJoinXT(2,:))))/T;
    end
end
[~,base_degree]=max(ave_LLR);
t_z_transform=zeros(length(node_distri),T);
t_z_transform(base_degree,:)=1:T;
%% Initialization
pda_join_x_z=Vmapping(base_degree-1).NProbJoinXT;
state_vec=zeros(1,length(node_distri));
state_vec(base_degree)=1;
for ii=1:length(node_distri)
    if(node_distri(ii)~=0&&ii~=base_degree)
        state_vec(ii)=2;     %Update state_vec
        [ pd_join_x_z,pd_z_given_t ] = message_alignment( Vmapping(ii-1).NProbJoinXT,pda_join_x_z,T);
        [ pd_z_given_y ] = mapping_update( pd_z_given_t,Vmapping(ii-1).ProbConTT1T2 );
        [ pda_join_x_z ] = average_update( pd_join_x_z,pda_join_x_z,state_vec,node_distri );    %update Pda(X,Z)
        state_vec(ii)=1;    %%Since it has been aligned, stste is turned into 1
        new_Vmapping(ii-1).NProbJoinXT=pd_join_x_z;     %update new_cmapping
        new_Vmapping(ii-1).ProbConTT1T2=pd_z_given_y;   %update new_cmapping
        for kk=1:T
            t_z_transform(ii,kk)=find(pd_z_given_t(kk,:)==1);
        end
    end
end

end



