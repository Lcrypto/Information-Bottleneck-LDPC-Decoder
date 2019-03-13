function [ Hmatrix ] = Hmatrix80211( protograph,cirsize )
%UNTITLED Summary of this function goes here
%   This function peroduce the H_matrix of 802.11 protocol
%   Input   protograph      tells which circulant that element should be 
                            % -1 --------> zeros matrix
                            % a(>=0)-----> number of shift 
%           cirsize         size of  circulants
[p_len,p_wid]=size(protograph);
Hmatrix=zeros(p_len*cirsize,p_wid*cirsize);
basic_i=eye(cirsize);
for ii=1:p_len
    for kk=1:p_wid
        row_start=(ii-1)*cirsize+1;
        row_end=(ii)*cirsize;
        column_start=(kk-1)*cirsize+1;
        column_end=(kk)*cirsize;
        if(row_start==15)
            a=1;
        end
        if protograph(ii,kk)==-1
            Hmatrix(row_start:row_end,column_start:column_end)=zeros(cirsize);
        else
            Hmatrix(row_start:row_end,column_start:column_end)=circshift(basic_i,-protograph(ii,kk)); %%second number should be negtive -> due to the direction
        end
    end
end

end

