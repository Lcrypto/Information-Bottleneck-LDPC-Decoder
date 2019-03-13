function [ o ] = RRatio( m )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
A1=0.7*0.8*m*0.2*0.2*0.6*0.35;
A0=(1-m)*0.3*0.2*0.8*0.8*0.4*0.65;
o=A1/A0;

end

