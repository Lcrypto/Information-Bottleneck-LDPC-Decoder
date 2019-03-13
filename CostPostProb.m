function [ ProbT0,ProbConXT0,ProbTL,ProbConXTL,ProbTR,ProbConXTR] = CostPostProb( EProbT, EProbConXT,ii)
%UNTITLED15 Summary of this function goes here
%   This Function is used for obtain the left/right/and extracted cluster
%   posterior probability
SizeET=length(EProbT);
ProbT0=EProbT(SizeET-1);                        %Prob of extracted Point
ProbConXT0=EProbConXT(:,SizeET-1);              %Prob of X given extracted point
ProbTL=EProbT(ii);                              %Prob of t of the left side of the boundary
ProbConXTL=EProbConXT(:,ii);                    %Prob of x given left side of the boundary
ProbTR=EProbT(ii+1);                            %Prob of t of the RIGHT side of the boundary
ProbConXTR=EProbConXT(:,ii+1);                  %Prob of x given RIGHT side of the boundary



end

