clc
close all;
clear all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Dominic Dougherty
% ASEN 4057
% 1/13/2022
% Homework 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Constants
g = -9.81; %m/s^2

%% Problem 1


V = input('Enter the initial velocity in m/s: '); %prompt the user for velocity and angle information
fprintf('\n');
theta = input('Enter launch angle in degrees: ');
theta = deg2rad(theta); %convert angle from degrees to radians
fprintf('\n');

tf = (V*sin(theta)/(-0.5*g));

t = linspace(0, tf);

x = zeros(1,length(t));  %Preset x and y vectors the same length as t
y = zeros(1,length(t));

x = V*cos(theta)*t; %calculate x location vector given input
y = 0.5*g*(t.^2) + V*sin(theta).*t; %calculate x location vector given input
x = x(y>0); %parse x, y, and t data to only include values where y>0
y = y(y>0);
t = t(y>0);

figure(1) %plot x and y values
plot(t, x)
grid on
axis([0 max(t) 0 max(x)])
xlabel('Time (s)')
ylabel('X-distance')
title('X-distance Travelled Over Time T')

figure(2)
plot(t, y)
grid on
axis([0 max(t) 0 max(y)])
xlabel('Time (s)')
ylabel('Y-distance')
title('Y-distance Travelled Over Time T')

%% Problem 2

alph = [-5 -2 0 2 3 5 7 10 14]; %Set up vectors with given data for alpha and Cl
cl = [-0.008 -0.003 0.001 0.005 0.007 0.006 0.009 0.017 0.019];

N = length(alph); %N is defined as the amount of data points of the alpha vector

A = sum(alph); %compute simplified numeric quantities with given equations
B = sum(cl);
C = alph.*cl;
C = sum(C);
D = sum((alph.^2));

m = ((A*B) - (N*C))/((A^2) - (N*D)); %calculate slop and intercept with given equations
b = ((A*C) - (B*D))/((A^2) - (N*D));

eq = m*alph + b; %calculate values of best fit line

figure(3) %plot the data as stars and the best fit line itself on the same graph
plot(alph, cl, '*')
hold on
plot(alph, eq);
grid on
legend('CL versus Alpha', 'Best Fit Line')

%% Problem 3

% Constants
rho0 = 1.225;
r = 3;
Wp = 5;
We = 0.6;
Wd = Wp + We;
h = 0;
M = 4.02;

%% Implementation - Problem 3
Alt = maxAlt(r, Wd, h, M);


