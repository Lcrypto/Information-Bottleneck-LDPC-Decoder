function [ H ] = parity_matrix_generater( varitable,checktable )
%UNTITLED Summary of this function goes here
%  
n=size(varitable,1);
[k,dc]=size(checktable);
H=zeros(k,n);
for ii=1:k
    for jj=1:dc
        H(ii,checktable(ii,jj))=1;
    end
end

end

