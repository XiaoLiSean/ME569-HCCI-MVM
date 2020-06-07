function [CA50, T_bd] = HCCI_Combustion(m_f, m_c, p_ivc, T_ivc, p_2)
%% Params for Arrhenius Integral & Combustion
%% Arrhenius Intergral Params
A           = 0.4167; % Arrhenius scaling constant
n           = 1.367; % reaction¡¯s sensitivity to pressure REF2[10]
Ea          = 1831930; % Arrhenius activation energy
R           = 296.25; % gas constant, J/KgK
%% Combustion Duration Params
b0          = 0.4086; % const term in k parametrization 
b1          = -0.0839; % Linear term in k dependence on theta_soc 
b2          = -0.0153; % Square term in k dependence on theta_soc

k           = 0.5397; 

c_v         = 0.740625; % constant volume specific heat (J/Kg.K) [17]
Q_LHV       = 44000; % low heating value of the fuel (KJ/Kg)

Ec          = 185; % Activation energy, KJ/mol
Ru          = 8.314; % Universal gas constant, J/mol K
nc          = 1.30; % Polytropic constant during compression
ne          = 1.35; % Polytropic constant during expansion
   
%% Load params for cylinder
V_d         = 5.5e-4; % Stroke (displacement) Volume, m^3
CR          = 14; % Cylinder compression ratio
V_TDC       = V_d / (CR - 1); % Vc when piston at TDC, m^3
%% Params for cylinder (Calculated)
B           = 8.6e-2; % Bore Diameter, m
r           = 2*V_d/(pi*B^2); % Crankshaft radius, m
rod_ratio   = 1.54; % GM L61 Ecotec Engine (2.2L);
l           = rod_ratio*2*r; % Connecting rod length
%% Solve theta_soc
syms theta T;
s           = r*(1-cos(theta)+l/r*(1-sqrt(1-(r*sin(theta)/l)^2))); % stroke, m
Vc          = V_TDC + s*pi*B^2/4;

theta_ivc   = 180*pi/180; % Crank angle at IVC, rad (Fig. 5)
theta_evo   = 180*pi/180; % Crank angle at EVO, rad (Fig. 5)
V_ivc       = double(subs(Vc, theta, theta_ivc));% Cylinder Volume of Intake Valve Closing (DBC), m^3

%% Phase 1: IVC to SOC
RR_theta    = A*((p_ivc*1e-3)^n)*(V_ivc/Vc)^(nc*n)*exp(-(Ea*(V_ivc/Vc)^(1-nc))/(R*T_ivc));
% p_ivc in KPa
threshold   = 0.01;
step_len    = 0.001;
T_tmp       = -theta_ivc:step_len:0;
T           = abs(T_tmp);
Riemann_sum = 0;
% theta_soc   = 0;
for i = 1:size(T,2)
    % v = double(subs(V_ivc/Vc, theta, T(i)))
    Riemann_sum = Riemann_sum + step_len * double(subs(RR_theta, theta, T(i)));
    % disp(Riemann_sum);
    if abs(Riemann_sum - 1) <= threshold
        theta_soc = T(i);
        break
    end
end
v_soc       = double(subs(V_ivc/Vc, theta, theta_soc));
T_soc       = T_ivc*v_soc^(nc-1);
% [theta_soc, T_soc] = AR_solver(p_ivc, T_ivc);
%% Phase 2: Combustion Duration
e           = b0 + b1*theta_soc + b2*theta_soc^2; % Verified Model from ChiangIEEE
Delta_T     = Q_LHV*m_f/c_v/m_c;
Tm          = T_soc + e*Delta_T; % Verified effective mean T Model from ChiangIEEE
Delta_theta = k*T_soc^(-2/3)*Tm^(1/3)*exp(Ec/(3*Ru*Tm));

theta_c     = theta_soc + Delta_theta;
CA50        = theta_soc + 0.55*Delta_theta;
% [theta_c, Delta_T, CA50, Tm] = comb_dur(b_c, AFR_c, theta_soc, T_soc);
%% Phase 3: Instantanous Heat Release
%% Params Before Combustion 
T_bc        = T_ivc*double(subs(V_ivc/Vc, theta, theta_c))^(nc-1);
p_bc        = p_ivc*double(subs(V_ivc/Vc, theta, theta_c))^nc;
%% Params After Combustion
T_ac        = T_bc + Delta_T; % Verified Model from ChiangIEEE
p_ac        = p_bc*T_ac/T_bc;
% [T_ac, p_ac] = heat_release(b_c, theta_c, Delta_T, p_ivc, T_ivc);
%% Phase 4: Polytropic Expansion
V_c          = double(subs(Vc, theta, theta_c)); % Cylinder Volume at theta_c, m^3
T_evo        = T_ac*double(subs(V_c/Vc, theta, theta_evo))^(ne-1);
p_evo        = p_ac*double(subs(V_c/Vc, theta, theta_evo))^ne;
% [T_evo, p_evo] = poly_exp(T_ac, p_ac, theta_c);
%% Phase 5: Exhaust Blowdown
T_bd         = T_evo*(p_2/p_evo)^((ne-1)/ne);
%% Output and Graph
plot([-theta_ivc -theta_soc -theta_soc+Delta_theta -theta_soc+Delta_theta theta_evo theta_evo]*180/pi, [T_ivc T_soc Tm T_ac T_evo T_bd],'o');
end

