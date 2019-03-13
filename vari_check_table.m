function [CheckTable,VariTable,vari_degree,check_degree] = vari_check_table(H,dc_max,dv_max)
%UNTITLED2 Summary of this function goes here
%   This functions is used to construct checktable and variable table 
%   input:      H       parity-check matrix
%   output:     checktable      checknode connections
               %varitable       varinode connections
                              
 [k,n]=size(H);
 CheckTable=zeros(k,dc_max);
 VariTable=zeros(n,dv_max);
 check_degree=zeros(1,k);
 vari_degree=zeros(1,n);
 for ii=1:k
     M=find(H(ii,:)~=0);
     CheckTable(ii,1:length(M))=M;
     check_degree(ii)=length(M);
 end

  for ii=1:n
     M=find(H(:,ii)~=0).';
     VariTable(ii,1:length(M))=M;
     vari_degree(ii)=length(M);
 end
 
end

