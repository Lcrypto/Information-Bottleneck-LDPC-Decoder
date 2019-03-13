function [ Output ] = Cost( Pry,Prt,Prxy,Prxt )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
Phi=Pry+Prt;
Pi0=Pry/Phi;
Pi1=Prt/Phi;
pr2=Pi0*Prxy+Pi1*Prxt;
JS_D=Pi0*KL(Prxy,pr2)+Pi1*KL(Prxt,pr2);
Output=Phi*JS_D;
end

