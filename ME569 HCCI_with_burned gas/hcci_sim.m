close all; clc;
clear all;
%% HCCI Eng. Model parameters
load_param;
%% Initial Condition (States)
m1_0        = p0*V1/(R*T1); % Intake manifold charge mass, Kg
m2_0        = p0*V2/(R*T1); % Exhaust manifold charge mass, Kg
b1_0        = 0.5; % Intake manifold burnt gas fraction
b2_0        = 1; % Exhaust manifold burnt gas fraction
p2_0        = p0; % Exhaust manifold pressure, KPa
AFR_EGO_0   = AFR_s; % AFR at EGO sensor
%% First engine cycle
%% MFD EVO to IVC
t_end       = tau / 2;
tstep       = 0.001;

time_in     = transpose(0:tstep:t_end);
Wc2_in      = 0.1*ones(size(time_in,1),1);
b_er_in     = 0.7*ones(size(time_in,1),1);
T_er_in     = 550*ones(size(time_in,1),1);

UT_in       = [time_in Wc2_in b_er_in T_er_in];
%% Simulation
options     = simset;
[time,states,output] = sim('hcci_eng',[0 t_end],options,UT_in);
% Index  1      2       3       4       5       6           7
% States [m1_0  p2_0    b1_0    m2_0    b2_0    AFR_EGO_0]
% Output [W1c   Wf      W2c     b_bd    AFR_c   p_ivc       T_ivc]

[CA50, T_bd] = HCCI_Combustion(output(end,5), output(end,6), output(end,7), states(end,2));



%% More engine cycles
cycle_num   = 10;
data_50 = zeros(cycle_num+1, 1);
data_50(1) = CA50;
for i = 1:cycle_num
    %% Initial State Update
    m1_0        = states(end,1); % Intake manifold charge mass, Kg
    m2_0        = states(end,4); % Exhaust manifold charge mass, Kg
    b1_0        = states(end,3); % Intake manifold burnt gas fraction
    b2_0        = states(end,5); % Exhaust manifold burnt gas fraction
    p2_0        = states(end,2); % Exhaust manifold pressure, KPa
    AFR_EGO_0   = states(end,6); % AFR at EGO sensor
    %% Delay States
    t_end       = tau;
    tstep       = 0.001;
    Wc2_in      = (sum(output(end,1:3)))*ones(size(time_in,1),1);
    b_er_in     = output(end,4)*ones(size(time_in,1),1);
    T_er_in     = T_bd*ones(size(time_in,1),1);
    %% Simulation
    UT_in       = [time_in Wc2_in b_er_in T_er_in];
    options     = simset;
    [time,states,output] = sim('hcci_eng',[0 t_end],options,UT_in);
    %% Combustion
    [CA50, T_bd] = HCCI_Combustion(output(end,5), output(end,6), output(end,7), states(end,2));
    data_50(i+1) = CA50;
   
end