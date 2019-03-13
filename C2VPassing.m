function [ Msg ] = C2VPassing(Neighbors,MsgV2C,i)
%This fuction is uesd to calulate the message passing
%from ith check node to jth variable node
%%[CNum, VNum]=size(H);

%A1=Neighbors;           %%delte check node j
%l_A1=length(A1);
% X=zeros(1,l_A1);
% for ii=1:l_A1
%     X(ii)=MsgV2C(i,A1(ii));
% end
X=MsgV2C(i,Neighbors);
Msg=2*atanh(prod(tanh(0.5*X)));
end

