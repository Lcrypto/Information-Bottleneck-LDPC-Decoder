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
clear all;
load('80211_irr_648_1296');
p_flag=0;
p_bits=0;
H_Class=H_Analyzer(H_Class.H,p_flag,p_bits);
H_Class.Analyze();