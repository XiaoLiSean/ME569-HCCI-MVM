p0          = 1.01; % ambient pressure, bar 
T1          = 90 + 273.15; % intake air temperature, K
dT_er2      = 75; % temperature drop based on test data from the exhaust runner to exhaust manifold
V1          = ???; % Intake manifold volume
V2          = ???; % Exhaust manifold volume
gamma       = 1.4 % ratio of specific heats for air (assume does not depend on inert gas fraction ACC04.P3)
            % Orifice specification A01 A20 A21 are unknow for now...
%% Initial Condition (States)
m1_0        = ???; % Intake manifold charge mass
m2_0        = ???; % Exhaust manifold charge mass
b1_0        = ???; % Intake manifold burnt gas fraction
b2_0        = ???; % Exhaust manifold burnt gas fraction
%% Params in Appendix Table
alpha_1     = 0.752; % Modulation of x_r by u_bbl 
alpha_2     = -0.180; % Modulation of x_r by u^2_bbl
alpha_3     = 0.015; % Modulation of x_r by u^3_bbl

beta_0      = 1.035; % Constant term of p_ivc, KPa
beta_1      = 1.1568; % Linear term of p_ivc

dT_bd       = -65; % Blowdown temperature difference   

kappa_0     = -2.2107; % Constant term of x_r 
kappa_1     = 61.5556; % Linear term of x_r 
kappa_2     = 4.6052; % p_2 exponent in x_r 
kappa_3     = 0.964; % p_1 exponent in x_r 

a0          = 1.0327; % Constant term in e parametrization 
a1          = -5.45; % Linear term, e dependence on k 

A           = 2500; % Arrhenius scaling constant

bk0         = 0.162; % const term in k parametrization 
bk1         = 0.005; % Linear term in k dependence on theta_soc 
bk2         = 0.001; % Square term in k dependence on theta_soc 

Ea          = 6317; % Arrhenius activation energy
Ec          = 185; % Activation energy, kJ/mol

nbd         = 1.35; % Adiabatic blowdown coefficient
nc          = 1.30; % Polytropic constant during compression
ne          = 1.35; % Polytropic constant during expansion

R           = 296.25; % gas constant, J/KgK
Ru          = 8.314; % Universal gas constant, J/mol K