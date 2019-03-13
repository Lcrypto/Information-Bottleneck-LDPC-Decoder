check_degree=zeros(1,size(CheckTable,1));
vari_degree=zeros(1,size(VariTable,1));
for ii=1:size(CheckTable,1)
    check_degree(ii)=nnz(CheckTable(ii,:));
end
for ii=1:size(VariTable,1)
    vari_degree(ii)=nnz(VariTable(ii,:));
end