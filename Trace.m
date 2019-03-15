function [  FirNum  ] = Trace( Combinations, lookuptable)

%UNTITLED10 Summary of this function goes here
%   flag: variable node or check node 
        %%flag==0 check node
        %%flag==1 variable node
    FirNum=Combinations(1);
for ii=1:length(Combinations)-1   
    SecNum=Combinations(ii+1);
    current_lt=lookuptable{ii};
    [FirNum]=current_lt(FirNum,SecNum);        
end 

