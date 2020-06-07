function [T_ac, p_ac] = heat_release(b_c, theta_c, Delta_T, p_ivc, T_ivc)
%% Params for Arrhenius Integral & Combustion
combustion_param;
%% Load params for cylinder
load_eng;
%% Params Before Combustion 
T_bc        = T_ivc*double(subs(V_ivc/Vc, theta, theta_c))^(nc-1);
p_bc        = p_ivc*double(subs(V_ivc/Vc, theta, theta_c))^nc;
%% Params After Combustion
T_ac        = T_bc + (1-b_c)*Delta_T;
p_ac        = p_bc*T_ac/T_bc;
end