function [ G,flag] = FrmHtoG( H )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
H_gf2=gf(H,2);      %%The whole process is in GF2
[num_chec,num_vari]=size(H_gf2);
num_msg=num_vari-num_chec;
H_left_square_part=H_gf2(:,1:num_chec);
H_right_non_square=H_gf2(:,num_chec+1:num_vari);
H_right_square_part=H_gf2(:,num_vari-num_chec+1:num_vari);
H_left_non_square=H_gf2(:,1:num_vari-num_chec);
if rank(H_left_square_part)==num_chec
    flag=1;
    G=[((H_left_square_part)\H_right_non_square).' eye(num_msg)];
elseif rank(H_right_square_part)==num_chec
    flag=1;
    G=[eye(num_msg) (H_right_square_part\H_left_non_square).'];
else 
    flag=0;
    G=0;        
end

end

