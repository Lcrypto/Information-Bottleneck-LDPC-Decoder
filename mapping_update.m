function [ pd_z_given_y ] = mapping_update( pd_z_given_t,pd_t_given_y )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
pd_z_given_y=pd_z_given_t.'*pd_t_given_y;

end

