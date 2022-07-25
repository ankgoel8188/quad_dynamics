clc
clear all
close all


time = [0 20];
x0 = [ones(3,1); zeros(9,1)];
x0(7) = 0.1
u = [-10; zeros(3,1)];

[t,y] = ode45(@(t,y) quad_dynamics(t,y,u),time,x0);

plot(t,y)