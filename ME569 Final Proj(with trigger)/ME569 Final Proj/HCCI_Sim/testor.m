clc; clear all;
p_ivc = 1.0100;
T_ivc = 460;
% p_ivc in Pa, T_ivc in K
%% Params for Arrhenius Integral
nc          = 1.30; % Polytropic constant during compression
A           = 3570e-5; % Arrhenius scaling constant
n           = 1.35; % reaction¡¯s sensitivity to pressure REF2[10]
Ea          = 6317; % Arrhenius activation energy
R           = 296.25; % gas constant, J/KgK
%% Params for cylinder
V_d         = 5.5e-4; % Stroke (displacement) Volume, m^3
CR          = 14; % Cylinder compression ratio
V_TDC        = V_d / (CR - 1); % Vc when piston at TDC, m^3
%% Params for cylinder (Calculated)
B           = 8.6e-2; % Bore Diameter, m
r           = 2*V_d/(pi*B^2); % Crankshaft radius, m
rod_ratio   = 1.54; % GM L61 Ecotec Engine (2.2L);
l           = rod_ratio*2*r; % Connecting rod length
%% Solve theta_soc
syms theta T;
s           = r*(1-cos(theta)+l/r*(1-sqrt(1-(r*sin(theta)/l)^2))); % stroke, m
Vc          = V_TDC + s*pi*B^2/4;

theta_ivc   = -140*pi/180; % Crank angle at IVC, rad (Fig. 5)
V_ivc       = double(subs(Vc, theta, theta_ivc));% Cylinder Volume of Intake Valve Closing (DBC), m^3

RR_theta    = A*(p_ivc^n)*(V_ivc/Vc)^(nc*n)*exp(-(Ea*(V_ivc/Vc)^(1-nc))/(R*T_ivc));

threshold   = 0.01;
step_len    = 0.001;
T           = theta_ivc:step_len:20*pi/180;
Riemann_sum = 0;

for i = 1:size(T,2)
    % v = double(subs(V_ivc/Vc, theta, T(i)))
    Riemann_sum = Riemann_sum + step_len * double(subs(RR_theta, theta, T(i)));
    disp(Riemann_sum);
    if abs(Riemann_sum - 1) <= threshold
        theta_soc = T(i);
        break
    end
end
