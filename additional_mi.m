function [ Cost ] = additional_mi( dist_vec,mapping,vc_flag,pda_join_x_z,T )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
                            
if vc_flag==1           %% Flag=1:    variable node  
    dif=1;
elseif vc_flag==0       %% Flag=0:    Check node
    dif=2;
else
    print('Wrong Input!');
    dif=Inf;
end
Cost=0;
pda_x_given_z=pda_join_x_z./sum(pda_join_x_z);
for ii=1:length(dist_vec)
    if(dist_vec(ii)~=0)
        prob_join_x_t=mapping(ii-dif).NProbJoinXT;
        prob_t=sum(prob_join_x_t);
        prob_x_given_t=prob_join_x_t./prob_t;
        local_cost=0;
        for jj=1:T
            if(sum(prob_join_x_t(:,jj))~=0)
            local_cost=local_cost+prob_t(jj)*KL(prob_x_given_t(:,jj),pda_x_given_z(:,jj));
            end

        end
        local_cost=dist_vec(ii)*local_cost;
        Cost=local_cost+Cost;
    end
    
end



end

