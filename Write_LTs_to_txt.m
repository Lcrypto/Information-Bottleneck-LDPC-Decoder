file=fopen('test.txt','wb');
a=[1 2 3];
for ii=1:3
    fprintf(file,'%d ',a(ii));
end
fprintf(file,'\n');

file=fopen('Lookup_Table.txt','wb');
fprintf(file,'%d \n',lookup_t.T);
fprintf(file,'%d \n',lookup_t.MaxIter);
fprintf(file,'%d \n',lookup_t.dc_max);
fprintf(file,'%d \n',lookup_t.dv_max);
for ii=1:lookup_t.MaxIter
    for jj=1:lookup_t.dc_max-2
        matrix=lookup_t.check_lt{ii,jj};
        for kk=1:lookup_t.T
            for hh=1:lookup_t.T
            fprintf(file,'%d ',matrix(hh,kk));
            end
            fprintf(file,'\n');
        end
    end
end
for ii=1:lookup_t.MaxIter
    for jj=1:lookup_t.dv_max
        matrix=lookup_t.vari_lt{ii,jj};
        for kk=1:lookup_t.T
            for hh=1:lookup_t.T
            fprintf(file,'%d ',matrix(hh,kk));
            end
            fprintf(file,'\n');
        end
    end
end