function [ new_pda_join_x_z ] = average_update( pd_join_x_z,old_pda_join_x_z,state_vec,distribution_vec )
%UNTITLED2 Summary of this function goes here
%   This function gives a updated distribution
%Input:     pd_join_x_z         probjoin_x_z that is required to be added
%           old_pda_join_x_z    previous Pda(X,Z)
%           State_vec           State Vector, which has the following
%           meaning
                    %   Index           Degree
                    %   0               Nothing happens
                    %   1               Has been aligned
                    %   2               Waited to be aligned
%           distrebution_vec    Node Degree Distribution
%Output:    new_pda_join_x_z    The aligend Pda(X,Z)

old_total=sum(distribution_vec(state_vec==1));
addition=distribution_vec(state_vec==2);
new_total=old_total+addition;
new_pda_join_x_z=(old_total/new_total)*old_pda_join_x_z+(addition/new_total)*pd_join_x_z;
new_pda_join_x_z=new_pda_join_x_z/sum(sum(new_pda_join_x_z));
end

