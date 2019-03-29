load('H_08');
punc_distri=[ 0 0 0 0 0 1];
iter_num=51;
example=Puncturing_Analysis(H_Class.vari_edge_dis,H_Class.check_edge_dis,punc_distri,iter_num);
example.go();