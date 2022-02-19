function [value,isterminal,direction] = myevents(t,y)
%{
Authors: Marissa Palamara, Dominic Dougherty
myevents.m
date: 26 February 2022
inputs:
    t = time (s)
    y = state vector (same as needed for trajectoryV2.m)
outputs:
    value = tells if condition occurs
    isterminal = if condition occurs, terminate or not
    direction = which direction to find zeros
summary: Function to determine if the satellite is within the Moon's radius
which would mean that it has crashed. Terminates ode45 if true.
%}

rM = 1737100; % m
% Detect Satellite-Moon Distance
dMs = distFunc(y(1),y(2),y(5),y(6));
if dMs <= rM
    value = 0;
else
    value = 1;
end
% Stop the integration
isterminal = 1;
% Direction
direction = 0;
end
