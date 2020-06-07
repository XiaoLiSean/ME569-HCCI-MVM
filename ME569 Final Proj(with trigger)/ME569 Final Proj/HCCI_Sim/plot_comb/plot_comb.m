clear all;
clc; close all;
%% Params for Arrhenius Integral & Combustion
combustion_param;
%% Load params for cylinder
load_eng;

%% Initial Condition for Calculation
AFR_c       = 20;
p_ivc       = 1.01e5;
T_ivc       = 450;
b_c         = 0.5;
p_2         = 1.8e5;

%% Phase 1: IVC to SOC
RR_theta    = A*((p_ivc*1e-5)^n)*(V_ivc/Vc)^(nc*n)*exp(-(Ea*(V_ivc/Vc)^(1-nc))/(R*T_ivc));

threshold   = 0.01;
step_len    = 0.001;
T_tmp       = -theta_ivc:step_len:0;
T           = abs(T_tmp);
Riemann_sum = 0;
for i = 1:size(T,2)
    % v = double(subs(V_ivc/Vc, theta, T(i)))
    Riemann_sum = Riemann_sum + step_len * double(subs(RR_theta, theta, T(i)));
    %disp(Riemann_sum);
    if abs(Riemann_sum - 1) <= threshold
        theta_soc = T(i);
        break
    end
end
v_soc       = double(subs(V_ivc/Vc, theta, theta_soc));
T_soc       = T_ivc*v_soc^(nc-1);
% [theta_soc, T_soc] = AR_solver(p_ivc, T_ivc);
%% Phase 2: Combustion Duration
k           = bk0 + bk1*theta_soc + bk2*theta_soc^2;
e           = a0 + a1*k;
Delta_T     = Q_LHV/c_v/(1+AFR_c);
Tm          = T_soc + e*(1-b_c)*Delta_T;% effective mean temperature
Delta_theta = k*T_soc^(-2/3)*Tm^(1/3)*exp(Ec/(3*Ru*Tm));

theta_c     = theta_soc + Delta_theta;
CA50        = theta_soc + 0.55*Delta_theta;
% [theta_c, Delta_T, CA50, Tm] = comb_dur(b_c, AFR_c, theta_soc, T_soc);
%% Phase 3: Instantanous Heat Release
%% Params Before Combustion 
T_bc        = T_ivc*double(subs(V_ivc/Vc, theta, theta_c))^(nc-1);
p_bc        = p_ivc*double(subs(V_ivc/Vc, theta, theta_c))^nc;
%% Params After Combustion
T_ac        = T_bc + (1-b_c)*Delta_T;
p_ac        = p_bc*T_ac/T_bc;
% [T_ac, p_ac] = heat_release(b_c, theta_c, Delta_T, p_ivc, T_ivc);
%% Phase 4: Polytropic Expansion
V_c          = double(subs(Vc, theta, theta_c)); % Cylinder Volume at theta_c, m^3
T_evo        = T_ac*double(subs(V_c/Vc, theta, theta_evo))^(ne-1);
p_evo        = p_ac*double(subs(V_c/Vc, theta, theta_evo))^ne;
% [T_evo, p_evo] = poly_exp(T_ac, p_ac, theta_c);
%% Phase 5: Exhaust Blowdown
T_bd        = T_evo*(p_2/p_evo)^((ne-1)/ne) + dT_bd;


plot([-theta_ivc -theta_soc theta_c theta_c theta_evo theta_evo]*180/pi, [T_ivc T_soc Tm T_ac T_evo T_bd],'o');