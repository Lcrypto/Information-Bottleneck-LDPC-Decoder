function [ averaged_distribution ] = average_distribution( dist_vec,mapping,vc_flag,T)
%UNTITLED6 Summary of this function goes here
%Input:     dist_vec        distribution vector
%           mapping         mapping
%           vc_flag         indicate variable or check node
                            % 1: variable node
                            % 0: check node
                            
if vc_flag==1
    dif=1;
elseif vc_flag==0
    dif=2;
else
    print('Wrong Input!');
    dif=Inf;
end
averaged_distribution=zeros(1,T);
for ii=1:length(dist_vec)
    if(dist_vec(ii)~=0)
        averaged_distribution=averaged_distribution+dist_vec(ii)*mapping(ii-dif).NProbJoinXT;
    end
end

end

