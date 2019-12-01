close all; clc;
clear all;
%% HCCI Eng. Model parameters
load_param;

%% Default Running Condition;
N       = 1000; % Fixed engine speed, rpm
theta   = ???; % lightly throttled engine running condition
tau     = 120 / N; % Engine cycle delay
C_d     = ???; % Contraction coefficient
A01     = ???; % Calibrated throttle orifice
A20     = ???; % Calibrated exhaust orifice
A21     = ???; % Calibrated eEGR valve orifice