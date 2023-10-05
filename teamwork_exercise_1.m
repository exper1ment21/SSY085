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
R_max = 28.6*1000;
pathLoss_max = G_uav*G_bs*(lambda_c/(4*pi*R_max))^2;

rainLoss_dB = -0.1; % dB/km
pathLoss_max = pathLoss_max*(10^(rainLoss_dB/10))^(R_max/1000);

F_dB = 13;
F = 10^(F_dB/10);
SNR_out_dB = 10; % change s.t Eb/N0 = 7 dB => SNR = 10 dB 
SNR_out = 10^(SNR_out_dB/10);
SNR_in = F*SNR_out; % SNR_in = P_rec/N_in = P_rec/(k*B*T0)

k = 1.38*10^(-23);
N_in = k*290*B;

% SNR_in = P_rec/N_in, P_rec = SNR_in*N_in = P_t*PL
% P_t = SNR_in*N_in/PL
P_t = SNR_in*N_in/pathLoss_max;

totalArea = 400*60*10^6 + 60*60*10^6;

delta_h = 100; 
d_cov = sqrt(R_max^2-delta_h^2);

N_y = @(d_cov,L_b) ceil(L_b/(2*d_cov*cosd(30))+1/2);
N_x = @(d_cov,L_a) ceil((L_a-d_cov*sind(30))/(3*d_cov*sind(30)));

N_x1 = N_x(d_cov,400*1000);
N_y1 = N_y(d_cov,60*1000);

N_x2 = N_x(d_cov,60*1000);
N_y2 = N_y(d_cov,60*1000);

numberOfBS = N_x1*N_y1+N_x2*N_y2;
