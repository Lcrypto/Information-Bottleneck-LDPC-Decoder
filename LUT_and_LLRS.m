prob_join_x_and_t_l=[
    5.6836e-5 1.5120e-6 5.4596e-4 7.2796e-6 0.0018 1.5566e-5 0.0019 1.2486e-5;
    0.2192 0.0018 0.2036 8.4581e-4 0.0635 1.7574e-4 0.0066 1.3693e-5
];

% prob_join_x_and_t_l=[
%     1.2713e-7 3.2181e-5 2.8171e-5 5.2329e-7 1.0784e-6 2.8970e-4 2.8056e-4 7.5670e-6 2.0862e-4 6.5832e-4 6.8954e-4 2.3958e-4 1.5889e-5 8.6270e-4 0.0010 1.2511e-5;
%     0.0014 0.1166 0.0983 6.0872e-4 0.0012 0.1059 0.0988 8.6220e-4 0.0078 0.0241 0.0277 0.0084 1.8258e-4 0.0032 0.0037 1.4486e-5
% ];


prob_x_and_t=[prob_join_x_and_t_l rot90(prob_join_x_and_t_l,2)];
T=size(prob_x_and_t,2);
deg=38;
CProbJoinXT1=prob_x_and_t;
CProbJoinXT2=CProbJoinXT1;
LLR_deg=zeros(deg-2,T);
LUT_matrix=zeros(T,T,deg-2);

for ii=1:deg-2
    [CMapping(1,ii),~,CProbJoinXT1] = BCNO( CProbJoinXT1,CProbJoinXT2,T,50);
    LLR_deg(ii,:)=LLR_Cal(CProbJoinXT1);
    LUT_matrix(:,:,ii)=lookup_table_matrix(CMapping(ii).Combo, CMapping(ii).ProbConTT1T2,T);
    fprintf("%d -- finished\n",ii);
end

save('testdata32.mat','LLR_deg','LUT_matrix','prob_x_and_t');


