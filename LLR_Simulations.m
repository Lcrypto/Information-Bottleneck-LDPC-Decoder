clear;
load('testdata32.mat')
itertime=100000;
T=32;
LLR_output=zeros(4,itertime);
prob_t_given_x1=prob_x_and_t(2,:)/sum(prob_x_and_t(2,:));
prob_in=sum(prob_x_and_t,1)./sum(sum(prob_x_and_t));
%prob_in=ones(1,T)/T;
msg_list=1:T;
LLR_xt=LLR_Cal(prob_x_and_t);
deg=4;
rv=List(msg_list,prob_in);
dev=zeros(1,deg);

 for kk=4:38
    [deg] = kk;
    tic
    for ii=1:itertime
        %%% Randomly generate messages
        [msg_cur] = rv.Random(deg-1,1);
        [LLR_cur] = LLR_xt(msg_cur);
        %%% calculate messages using BP
        [llr_bp] = TanT(LLR_cur);
        [LLR_output(1,ii)] = llr_bp;
        %%% calculte messages using ib and obtain corresponding LLR
        [fir_num] = msg_cur(1);
        for jj=1:deg-2
            [sec_num] = msg_cur(jj+1);
            [fir_num] = LUT_matrix(fir_num,sec_num,jj);
        end
        [LLR_output(2,ii)] = LLR_deg(deg-2,fir_num);
        %%% calculate PDF of output
    end
    toc
    LLR_output(3,:)=abs(LLR_output(1,:)-LLR_output(2,:));
    LLR_output(4,:)=sign(LLR_output(1,:)).*(LLR_output(1,:)-LLR_output(2,:));
%     plot(LLR_output(4,:));
%     ylim([-3 3]);
    dev(kk)=sum(LLR_output(3,:))/itertime;
    scatter(LLR_output(1,:),LLR_output(2,:));
    axis([-10 10 -10 10])
    hold on;
    plot(-10:0.1:10,-10:0.1:10);
    pause(0.3);
    hold off;
    if deg == 18
        pause;
    end
    
    fprintf("deg: %d -- finished -- with average %f loss\n", deg, dev(kk));
  
    
    
end
figure;
  plot(dev);
  xlabel('degree');
  ylabel('average LLR loss compared with thanh');
  

% %%% plot
% [binranges]=-10:0.1:10;
% [bincounts_bp] = histc(LLR_output(1,:),binranges);
% [bincounts_ib] = histc(LLR_output(2,:),binranges);
% bar(binranges,bincounts_bp,'histc','red');
% hold on;
% bar(binranges,bincounts_ib,'histc','r');


