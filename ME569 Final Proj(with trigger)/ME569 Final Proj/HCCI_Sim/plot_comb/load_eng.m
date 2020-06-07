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

theta_ivc   = 140*pi/180; % Crank angle at IVC, rad (Fig. 5)
theta_evo   = 130*pi/180; % Crank angle at EVO, rad (Fig. 5)
V_ivc       = double(subs(Vc, theta, theta_ivc));% Cylinder Volume of Intake Valve Closing (DBC), m^3