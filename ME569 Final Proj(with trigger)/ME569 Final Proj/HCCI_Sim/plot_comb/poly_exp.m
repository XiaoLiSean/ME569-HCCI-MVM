function [T_evo, p_evo] = expansion(T_ac, p_ac, theta_c)
%% Params for Arrhenius Integral & Combustion
%% Params for Arrhenius Integral & Combustion
combustion_param;
%% Load params for cylinder
load_eng;
%% Calculation
V_c          = double(subs(Vc, theta, theta_c)); % Cylinder Volume at theta_c, m^3
T_evo        = T_ac*double(subs(V_c/Vc, theta, theta_evo))^(ne-1);
p_evo        = p_ac*double(subs(V_c/Vc, theta, theta_evo))^ne;
end