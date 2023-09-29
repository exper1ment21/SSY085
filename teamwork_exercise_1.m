%% Teamwork exercise 1
clear
clc

Ae_bs = 1;
f_c = 25*10^9;
c = 3*10^8;
lambda_c = c/f_c;

G_bs = (4*pi)/lambda_c^2*Ae_bs;
G_uav = 1;
R_max = 6000;
pathLoss_max = G_uav*G_bs*(lambda_c/(4*pi*R_max))^2;

