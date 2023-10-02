%% Teamwork exercise 1
clear
clc

% Downlink:
% transmit 100 kbps/user to ten spatially different users
% Uplink:
% Every user transmits 2 Mbps to BS
% Use TDD with 0.1/2 ratio between DL and UL

% QPSK in UL: R_b_req = 2*B*(2/2.1) = 2 Mbps
% Assume 50% overhead bits
% R_b_actual = 4 Mbps = 2*B*(2/2.1)
% B = 4M/2*2.1/2

B = 4*10^6*2.1/4;
Ae_bs = 1;
f_c = 5*10^9;
c = 3*10^8;
lambda_c = c/f_c;
(2/lambda_c)^2

G_bs = (4*pi)/lambda_c^2*Ae_bs;
G_uav = 1;
R_max = 6000;
pathLoss_max = G_uav*G_bs*(lambda_c/(4*pi*R_max))^2;

delta_h = 100; 
d = sqrt(R_max^2-delta_h^2);

rainLoss_dB = -1; % dB/km
pathLoss_max = pathLoss_max*(10^(rainLoss_dB/10))^(R_max/1000);

F_dB = 13;
F = 10^(F_dB/10);
SNR_out_dB = 7;
SNR_out = 10^(SNR_out_dB/10);
SNR_in = F*SNR_out; % SNR_in = P_rec/N_in = P_rec/(k*B*T0)

k = 1.38*10^(-23);
N_in = k*290*B;

% SNR_in = P_rec/N_in, P_rec = SNR_in*N_in = P_t*PL
% P_t = SNR_in*N_in/PL
P_t = SNR_in*N_in/pathLoss_max;