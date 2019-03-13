



function [ new_lookuptable  ] = lookup_table_modification( Lookup_table,flag )
%UNTITLED3 Summary of this function goes here
%  Flag=1       Vari;
%  Flag=0       Check;

T=size(Lookup_table,1);
Pre_r=zeros(T,2);
Pre_c=zeros(2,T+2);
Lookup_table=[Lookup_table(:,1:T/2) Pre_r Lookup_table(:,T/2+1:end)];
Lookup_table=[Lookup_table(1:T/2,:);Pre_c;Lookup_table(T/2+1:end,:)];

if flag==1
    Lookup_table(T/2+1,:)=1:T+2;
    Lookup_table(T/2+2,:)=1:T+2;
    Lookup_table(:,T/2+1)=1:T+2;
    Lookup_table(:,T/2+2)=1:T+2;
else
    Lookup_table(T/2+1,:)=T/2+1;
    Lookup_table(T/2+2,:)=T/2+2;
    Lookup_table(:,T/2+1)=T/2+1;
    Lookup_table(:,T/2+2)=T/2+2;
end

for ii=1:T+2
    for jj=1:T+2
        if (ii~=T/2+1&&ii~=T/2+2)
            if(jj~=T/2+1&&jj~=T/2+2)
                if(Lookup_table(ii,jj)>T/2)
                    Lookup_table(ii,jj)=Lookup_table(ii,jj)+2;
                end
            end
        end
    end
    
end

new_lookuptable= Lookup_table;


end




