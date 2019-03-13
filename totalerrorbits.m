function [ totalbits,totalerror ] = totalerrorbits( currentbits,cwlength,currenterror,finalbits,bits )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
totalbits=currentbits+cwlength;
totalerror=currenterror+sum(finalbits~=bits);

end

