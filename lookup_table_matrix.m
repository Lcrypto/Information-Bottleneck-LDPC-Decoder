function [ lt_matrix ] = lookup_table_matrix( Combination,pr_t_given_t1t2,T)
%UNTITLED Summary of this function goes here
%   this function means to output a  2-d matrix
        % row           first input
        % column        second input
        % value         mapping
lt_matrix=zeros(T);
for ii=1:T^2
    lt_matrix(Combination(ii,1),Combination(ii,2))=find(pr_t_given_t1t2(:,ii)~=0);
end

        


end

