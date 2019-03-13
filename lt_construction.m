
function [vari_lt,check_lt]=lt_construction(MaxIter,dc_max,dv_max,VMapping,CMapping,T)

%%%%This function is used to construct look-up table
vari_lt=cell(MaxIter,dv_max);
check_lt=cell(MaxIter,dc_max-2);
for ii=1:MaxIter
    for jj=1:dv_max         %% CONSTRUCT  variable node lookup table
        vari_lt{ii,jj}=lookup_table_matrix(VMapping(ii,jj).Combo, VMapping(ii,jj).ProbConTT1T2,T);
    end
end

for ii=1:MaxIter
    for jj=1:dc_max-2
        check_lt{ii,jj}=lookup_table_matrix(CMapping(ii,jj).Combo,CMapping(ii,jj).ProbConTT1T2,T);
    end
end

end
    
