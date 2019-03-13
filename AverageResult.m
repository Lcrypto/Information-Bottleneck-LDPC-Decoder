Run=100;
T=8;
Final=zeros(8,T);
for ii=1:8
    Final(ii,:)=sum(Result(:,:,ii),1)/Run;
end
Final=OptimalResult;
%%  Plot Part
 for ii=1:8
     for jj=2:T
         ParPoint(ii,jj)=0.002*(sum(Final(ii,1:jj-1)))-2;
     end
 end
 Final2=[-2*ones(8,1) ParPoint(:,2:T) 2*ones(8,1)];
 figure;
 hold on;
 y=0.1:0.1:0.8;
 for ii=1:(T+1)
     plot((Final2(:,ii)'),y,'-o');
 end
 xlabel('Channel Observation');
 ylabel('\sigma^2_n');
 grid on;
 