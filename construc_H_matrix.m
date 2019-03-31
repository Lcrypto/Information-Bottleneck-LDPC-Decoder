%%%%%max-variable-index-67584
%%%%%max-check----index-51200
% H=zeros(2193,3225);
% for ii=1:size(K_1032_TCOM_3_43_ACEPEG_6_12_Chinn,1)
%     H(K_1032_TCOM_3_43_ACEPEG_6_12_Chinn(ii,2)+1,K_1032_TCOM_3_43_ACEPEG_6_12_Chinn(ii,1)+1)=1;
% end
% p_flag=1;
% p_bits=129;
% % 
% % % H_anains=1;
% % % clear all;
% % % load('80211_irr_648_1296');
% % % p_flag=0;
% % % p_bits=0;
% H_Class=H_Analyzer(H,p_flag,p_bits);
% H_Class.Analyze();
clear;
load('Chinn');

% lifter=129;
% rate=2/3;
% myfile=fopen('rate05.txt','wb');
% vari_num=(1+8/rate)*lifter;
% fprintf(myfile,'%d\n',vari_num);
% check_num=(8/rate-7)*lifter;
% fprintf(myfile,'%d\n',check_num);
% H2=H_Class.H(1:check_num,1:vari_num);
% H_Class=H_Analyzer(H2,1,129);
% H_Class.Analyze();
% edge1=sum(H_Class.vari_degree(1:vari_num));
% edge2=sum(H_Class.check_degree(1:check_num));
% if edge1==edge2
%     fprintf(myfile,'%d\n',edge1);
% else
%     disp('Edges are not Equal!');
%     return;
% end
% vari_max=max(H_Class.vari_degree(1:vari_num));
% fprintf(myfile,'%d\n',vari_max);
% check_max=max(H_Class.check_degree(1:check_num));
% fprintf(myfile,'%d\n',check_max);
% for ii=1:vari_num
%     fprintf(myfile,'%d %d\n',ii-1,H_Class.vari_degree(ii));
% end
% for ii=1:check_num
%     fprintf(myfile,'%d %d\n',ii-1,H_Class.check_degree(ii));
% end
% sum=0;
% for ii=1:vari_num
%     cur_edge=find(H_Class.H(:,ii));
%     sum=length(cur_edge)+sum;
%     for jj=1:length(cur_edge)
%         fprintf(myfile,'%d %d\n',ii-1,cur_edge(jj)-1);
%     end
% end
% fclose('all');
load('LT-PBRL-R08-E21-T16-0');
myfile=fopen('new.txt','wb');
%%wirte check table
for ii=1:50
    for jj=1:length(lookup_t.check_distri_vec)
        for kk=1:16
            fprintf(myfile,'%d ',lookup_t.check_node_transform(jj,kk,ii));
        end
        fprintf(myfile,'\n ');
    end
end



