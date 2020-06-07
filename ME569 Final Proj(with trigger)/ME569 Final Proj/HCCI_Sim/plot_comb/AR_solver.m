function [theta_soc, T_soc]= AR_solver(p_ivc, T_ivc)
% p_ivc in Pa, T_ivc in K
p_ivc = p_ivc / 100000;
%% Params for Arrhenius Integral & Combustion
combustion_param;
%% Load params for cylinder
load_eng;
%% Calculate theta SOC
RR_theta    = A*(p_ivc^n)*(V_ivc/Vc)^(nc*n)*exp(-(Ea*(V_ivc/Vc)^(1-nc))/(R*T_ivc));

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
end