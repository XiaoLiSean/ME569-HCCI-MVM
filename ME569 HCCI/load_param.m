%% Orifice specification A01 A20 A21 are unknow for now...
C_d     = 1; % Contraction coefficient (assume)
f       = @(u) 2.821 - 0.05231*u + 0.10299*u*u - 0.00063*u*u*u;
A01     = f(90); % Calibrated throttle orifice
A20     = f(70); % Calibrated exhaust orifice
A21     = f(50); % Calibrated eEGR valve orifice

%% Default Running Condition;
N       = 1000; % Fixed engine speed, rpm
Wf      = 11.9e-6; % Constant fuel injection rate, Kg/sec
AFR_s   = 20; % Stoichiometry AFR (run lean)
u_rbl   = 3; % Rebreathing valve lift, mm
tau     = 120 / N; % Engine cycle delay, sec
tau_EGO = 0.08; % EGO sensor time constant, sec; from HW4

p0          = 101000; % ambient pressure, Pa 
T1          = 90 + 273.15; % intake air temperature, K
dT_er2      = 75; % temperature drop based on test data from the exhaust runner to exhaust manifold

V1          = 0.0013; % Intake manifold volume, m^3 !REFChiangIEEE
V2          = 0.015; % Exhaust manifold volume, m^3 !REFChiangIEEE
A2          = 0.3149; % Exh manifold heat transfer area m^2
h2          = 267; % Exh manifold heat transfer coeff W/m^2-K
T_w         = 400; %wall temperature K
V_d         = 5.5e-4; % Stroke (displacement) Volume, m^3
CR          = 14; % Cylinder compression ratio
V_TDC       = V_d / (CR - 1); % V_c when piston at TDC, m^3
V_ivc       = V_d + V_TDC; % Cylinder Volume of Intake Valve Closing (DBC), m^3
V_BDC       = V_ivc;

gamma       = 1.4; % ratio of specific heats for air (assume does not depend on inert gas fraction ACC04.P3)
%% Params in Appendix Table
alpha       = 0.5794;

beta_0      = 1.035; % Constant term of p_ivc, KPa
beta_1      = 1.1568; % Linear term of p_ivc

% dT_bd       = -65; % Blowdown temperature difference   

kappa_0     = 0.5729; % Constant term of x_r 
kappa_1     = -0.52039; % Linear term of x_r 

% a0          = 1.0327; % Constant term in e parametrization 
% a1          = -5.45; % Linear term, e dependence on k 
% 
% A           = 2500; % Arrhenius scaling constant
% 
% bk0         = 0.162; % const term in k parametrization 
% bk1         = 0.005; % Linear term in k dependence on theta_soc 
% bk2         = 0.001; % Square term in k dependence on theta_soc 
% 
% Ea          = 6317; % Arrhenius activation energy
% Ec          = 185; % Activation energy, kJ/mol

nbd         = 1.35; % Adiabatic blowdown coefficient
nc          = 1.30; % Polytropic constant during compression
ne          = 1.35; % Polytropic constant during expansion

R           = 296.25; % gas constant, J/KgK
Ru          = 8.314; % Universal gas constant, J/mol K