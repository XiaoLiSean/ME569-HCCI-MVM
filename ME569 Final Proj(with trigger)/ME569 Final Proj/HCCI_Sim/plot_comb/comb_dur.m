function [theta_c, Delta_T, CA50, Tm] = comb_dur(b_c, AFR_c, theta_soc, T_soc)
%% Params for Arrhenius Integral & Combustion
combustion_param;
%% Calculation
k           = bk0 + bk1*theta_soc + bk2*theta_soc^2;
e           = a0 + a1*k;
Delta_T     = Q_LHV/c_v/(1+AFR_c);
Tm          = T_soc + e*(1-b_c)*Delta_T;% effective mean temperature
Delta_theta = k*T_soc^(-2/3)*Tm^(1/3)*exp(Ec/(3*Ru*Tm));

theta_c     = theta_soc + Delta_theta;
CA50        = theta_soc + 0.55*Delta_theta;
end