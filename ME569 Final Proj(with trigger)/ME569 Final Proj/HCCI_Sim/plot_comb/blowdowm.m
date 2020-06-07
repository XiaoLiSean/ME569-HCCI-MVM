function T_bd = blowdowm(T_evo, p_evo, p2)
%% Params for Arrhenius Integral & Combustion
combustion_param;
%% Load params for cylinder
load_eng;
%% Blowdown
T_bd        = T_evo*(p2/p_evo)^((ne-1)/ne) + dT_bd;
end