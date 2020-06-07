clear all; close all; clc

p1 = 1.01;
p2 = 1.2;

x = 2.2:0.1:4;
p = 0.752*x-0.180*x.^2+0.015*x.^3;
xr = p*(-1+62*p1^0.964/p2^4.6052/sqrt(500));

plot(x, xr, 'r*');