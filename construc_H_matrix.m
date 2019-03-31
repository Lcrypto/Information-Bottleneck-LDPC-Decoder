%%%%%max-variable-index-67584
%%%%%max-check----index-51200
% H=zeros(51200,67584);
% for ii=1:size(k16384,1)
%     H(k16384(ii,2)+1,k16384(ii,1)+1)=1;
% end
% p_flag=1;
% p_bits=2048;
% liftingfactor=2048;
% 
% H_anains=1;
% clear all;
% load('20433484');
% p_flag=0;
% p_bits=0;
% H_Class=H_Analyzer(H,p_flag,p_bits);
% H_Class.Analyze();
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
% clear;
% load('Chinn');
% 
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
% load('LT-PBRL-R08-E21-T16-0');
% myfile=fopen('new.txt','wb');
% %%wirte check table
% for ii=1:50
%     for jj=1:length(lookup_t.check_distri_vec)
%         for kk=1:16
%             fprintf(myfile,'%d ',lookup_t.check_node_transform(jj,kk,ii));
%         end
%         fprintf(myfile,'\n ');
%     end
% end


%% Construct text file for H
clear
load('80211_irr_648_1296');
myfile=fopen('80211_irr_648_1296.txt','wb');
fprintf(myfile,'%d\n',H_Class.n);
fprintf(myfile,'%d\n',H_Class.k);
H_Class.Analyze();
edge1=sum(H_Class.vari_degree(:));
edge2=sum(H_Class.check_degree(:));
if edge1==edge2
    fprintf(myfile,'%d\n',edge1);
else
    disp('Edges are not Equal!');
    return;
end
vari_max=max(H_Class.vari_degree(:));
fprintf(myfile,'%d\n',vari_max);
check_max=max(H_Class.check_degree(:));
fprintf(myfile,'%d\n',check_max);
for ii=1:H_Class.n
    fprintf(myfile,'%d %d\n',ii-1,H_Class.vari_degree(ii));
end
for ii=1:H_Class.k
    fprintf(myfile,'%d %d\n',ii-1,H_Class.check_degree(ii));
end
Sum=0;
for ii=1:H_Class.n
    cur_edge=find(H_Class.H(:,ii));
    Sum=length(cur_edge)+Sum;
    for jj=1:length(cur_edge)
        fprintf(myfile,'%d %d\n',ii-1,cur_edge(jj)-1);
    end
end
fclose('all');

%% Sudarsan
%%%Construc discription -Sudarsan%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Line 1: Name of the parity-check matrix file
%Line 2: Number of information bits
%Line 3: Number of variable nodes
%Line 4: "1" if puncturing is present. "0" otherwise
%Line 5: If Line 4 is "1", indicate the number of punctured variable nodes
%Line 6 through end: If Line 4 is "1", provide the list of punctured variable nodes
% myfile=fopen('code_description.txt','wb');
% fprintf(myfile,'H_20433484.txt\n');
% fprintf(myfile,'%d\n',H_Class.n-H_Class.k);
% fprintf(myfile,'%d\n',H_Class.n);
% fprintf(myfile,'%d\n',0);
% fclose('all');
%%%Sudarsan H Matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Line 1: Number of variable nodes
%Line 2: Number of check nodes
%Line 3: Number of edges in the graph
%Line 4: Field size (always set to 2 for binary; this line is present because I also used to do non-binary codes in another decoder file)
%Line 5: Max degree of variable nodes
%Line 6: Max degree of check nodes
%Line 7 through end: <vnode index><space><cnode index>
% myfile=fopen('H_20433484.txt','wb');
% fprintf(myfile,'%d\n',H_Class.n);
% fprintf(myfile,'%d\n',H_Class.k);
% edge1=sum(H_Class.vari_degree(:));
% fprintf(myfile,'%d\n',edge1);
% fprintf(myfile,'%d\n',2);
% vari_max=max(H_Class.vari_degree(:));
% fprintf(myfile,'%d\n',vari_max);
% check_max=max(H_Class.check_degree(:));
% fprintf(myfile,'%d\n',check_max);
% Sum=0;
% for ii=1:H_Class.n
%     cur_edge=find(H_Class.H(:,ii));
%     Sum=length(cur_edge)+Sum;
%     for jj=1:length(cur_edge)
%         fprintf(myfile,'%d %d\n',ii-1,cur_edge(jj)-1);
%     end
% end
% fclose('all');


