function [ DisCW ] = Discrete( CW,Max,Min,T )
%   This fuction discretize continuous channel observation into discrete
%   values
%   Input:  CW:     Input Continuous Codeword
%           Max:    The max allowed number
%           Min:    The min allowed number
%           T:      Channle Size Number
%   Output: DisCW:  Discrete Unsigned Numbers

%%%%%%Version 2.0
delta=(Max-Min)/T;
left_first=Min-delta/2;
left_end=Max-delta/2;
quantize_interval=linspace(left_first,left_end,T);
DisCW=zeros(1,length(CW));
for ii=1:length(CW)
    if(CW(ii))<=left_first
        DisCW(ii)=1;
    else
        difference=CW(ii)*ones(1,T)-quantize_interval;
        [~,position]=find(difference>0);
        DisCW(ii)=position(end);
    end
end
end

