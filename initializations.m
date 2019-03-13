function [var_conn, link]= initializations(H_given, num_var, num_check, gamma)
        
        [a,b] = size(H_given);
        H_inter = H_given + ones(a,b);
        link = zeros(130,6);
        var_conn= zeros(260,3);

        for i=1: num_var                                    % This is to determine links with each variable node
          c = 1;
          for j = 1:a                                       % This is to scan the entire matrix for a given check node
             if H_inter(j,2)== i;
                var_conn(i,c)= H_inter(j,1);                % Variable nodes are numbered from 0 to n-1
                c=c+1;                                      % Check nodes are numbered from 1 to n-k.
             else                                 
             end
          end
        end

        for i=1: num_check                                  % This is to determine links with each variable node
                c = 1;                                      % Link matrix is generated through this loop
                for j = 1:a                                 % This is to scan the entire matrix for a given check node
                    if H_inter(j,1)== i;
                       link(i,c)= H_inter(j,2)-1;           % Variable nodes are numbered from 0 to n-1
                       c=c+1;                               % Check nodes are numbered from 1 to n-k.
                    else
                    end
                end
        end
end