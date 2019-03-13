function [ R ] = RIFS( S,n )
%UNTITLED3 Summary of this function goes here
%   This function is used to realize generating random integer with fixed
%   sum
%   This function is actually https://www.mathworks.com/matlabcentral/
%   answers/327656-conditional-random-number-generation#answer_257296
%   S: The Sum of all the random integers
%   n: Number of all the random integers
% 
% 
% m = 1;
% while true
%   P = ones(S+1,n);
%   for in = n-1:-1:1
%    P(:,in) = cumsum(P(:,in+1));
%   end
%   R = zeros(m,n);
%   for im = 1:m
%    s = S;
%    for in = 1:n
%     R(im,in) = sum(P(s+1,in)*rand<=P(1:s,in));
%     s = s-R(im,in);
%    end
%   end
%   x = find(R<=0);
%   if x~=0
%       continue
%   else 
%       break
%   end
% end
% indMaxArry = ceil(n/2);
% R = circshift(sort(R),[0,indMaxArry]);
% 
% end

%% Method 2
if(S<n)
    c=1;
end
R = diff([0,sort(randperm(S-1,n-1)),S]);
