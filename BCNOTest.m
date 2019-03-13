% This function is used to test BCNO 
 %SS=0.5*[0.0193 0.0873 0.2304 0.6625; 0.6625 0.2304 0.0873 0.0193];
 prob_join_xt=prob_join_xt./sum(sum(prob_join_xt));
 [Mapping,NProbJoinXT]=BVNO(prob_join_xt,prob_join_xt,10,100);