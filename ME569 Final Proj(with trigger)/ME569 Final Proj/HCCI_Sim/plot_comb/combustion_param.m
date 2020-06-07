%% Arrhenius Intergral Params
A           = 3570e-5; % Arrhenius scaling constant
n           = 1.35; % reaction¡¯s sensitivity to pressure REF2[10]
Ea          = 6317; % Arrhenius activation energy
R           = 296.25; % gas constant, J/KgK
%% Combustion Duration Params
bk0         = 0.162; % const term in k parametrization 
bk1         = 0.005; % Linear term in k dependence on theta_soc 
bk2         = 0.001; % Square term in k dependence on theta_soc

a0          = 1.0327; % Constant term in e parametrization 
a1          = -5.45; % Linear term, e dependence on k 

c_v          = 1.4; % constant volume specific heat (KJ/Kg.K) [17]
Q_LHV       = 43960; % low heating value of the fuel (KJ/Kg)

Ec          = 185; % Activation energy, kJ/mol
Ru          = 8.314; % Universal gas constant, J/mol K
nc          = 1.30; % Polytropic constant during compression
ne          = 1.35; % Polytropic constant during expansion

dT_bd       = -65; % Blowdown temperature difference   