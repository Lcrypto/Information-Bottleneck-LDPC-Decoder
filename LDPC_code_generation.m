load('20433484.mat');
[num_chec,num_vari]=size(H);
num_msg=num_vari-num_chec;
num_frame=20;
msg_bits=binornd(1,0.5,[num_frame,num_msg]);
sigma2=5;
Index=1;
BER=zeros(1,10);
CodeRate=0.5;
for Eb_N0=0:0.5:4
    if Eb_N0<=2
    moto_time=10;
    elseif Eb_N0<=3
        moto_time=10;
    else
        moto_time=10;
    end
    num_wrong_bits=zeros(1,moto_time);
    parfor kk=1:moto_time
        msg_trans=zeros(num_frame,num_vari);
        msg_dec=zeros(num_frame,num_vari);
        for ii=1:num_frame
            msg_trans(ii,:)=mod(msg_bits(ii,:)*G,2);
        end
        msg_cw=-2*msg_trans+1;
        sigma2=10^(-0.1*Eb_N0)/(2*CodeRate);
        msg_cw_noise=msg_cw+normrnd(0,sqrt(sigma2),num_frame,num_vari);
        for ii=1:num_frame
            LLR_in=(msg_cw_noise(ii,:)*(2/sigma2));
            msg_dec(ii,:)= LDPC_Decoder(LLR_in,H,50);
        end
        num_wrong_bits(kk)=sum(sum(msg_dec~=msg_trans));
    end
    BER(Index)=sum(num_wrong_bits)/(moto_time*num_vari*num_frame);
    Index=Index+1;
end
