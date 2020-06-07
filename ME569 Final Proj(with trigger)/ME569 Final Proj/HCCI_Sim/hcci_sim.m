close all; clc;
clear all;
%% HCCI Eng. Model parameters
load_param;

%% Input
t_end = 5*tau;
tstep = 0.1;

time_in  = transpose(0:tstep:t_end);
UT_in    = time_in;

%% Simulation
options = simset;
[time,states,output] = sim('hcci_eng_with_delay',[0 t_end],options,UT_in);