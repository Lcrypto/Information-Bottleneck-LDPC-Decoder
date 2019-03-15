function [ pd_join_x_z,t_z_transform ] = message_alignment( pd_join_x_t,pda_join_x_z,T)
%This function is a elementary operation of message_alignment
%Input:     pd_join_x_t         The Pd(X,T) that needs to be aligned
%           pda_join_x_z        Currerntly Averageed Pd(X,Z)
%Output:    pd_z_given_t        Mapping Matrix from t to z
%           pd_join_x_z         P(X,Z) is aligned joint probability
%           T                   Cardinality
%% Initialize
pd_z_given_t=zeros(T);                                  %%row->t column->z
pd_x_given_t=pd_join_x_t./sum(pd_join_x_t);             %%Obtian  Pd(X|T)
pda_x_given_z=pda_join_x_z./sum(pda_join_x_z);          %%Obtian  Pda(X|Z)
%%%Add Zero LLR Condition!
LLR=LLR_Cal(pd_join_x_t);
if LLR(T/2)==0
    check_time=T/2-1;           %%only check half time --> symmetry
else
    check_time=T/2;
end

for ii=1:check_time
    divergence=zeros(1,check_time);
    cur_pd_x_given_t=pd_x_given_t(:,ii);
    for jj=1:length(divergence)
        cur_pda_x_given_z=pda_x_given_z(:,jj);
        divergence(jj)= KL(cur_pd_x_given_t,cur_pda_x_given_z);
    end
    %    divergence(sum(pd_z_given_t)==1)=Inf;               %Avoide Overlap
    [~,minpos]=min(divergence);
    pd_z_given_t(ii,minpos)=1;
    
end
if check_time == T/2-1
    pd_z_given_t(T/2,T/2)=1;
end
pd_z_given_t(:,T/2+1:end)=rot90(pd_z_given_t(:,1:T/2),2);
pd_join_x_z=pd_join_x_t*pd_z_given_t;
for kk=1:T
    t_z_transform(kk)=find(pd_z_given_t(kk,:)==1);
end
end

