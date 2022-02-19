function [value,isterminal,direction] = myeventsOpt1(t,y)
%{
Authors: Marissa Palamara, Dominic Dougherty
myeventsOpt1.m
date: 26 February 2022
inputs:
    t = time (s)
    y = state vector (same as needed for trajectoryV2.m)
outputs:
    value = tells if condition occurs
    isterminal = if condition occurs, terminate or not
    direction = which direction to find zeros
summary: Function to determine if the satellite will miss the Moon.
Terminates if dEs < rE AND dMs is never less than rM
%}
rE = 63710000; % m
rM = 1737100; % m
% Detect Satellite-Moon Distance
dEs = distFunc(y(1),y(2),y(9),y(10));
dMs = distFunc(y(1),y(2),y(5),y(6));
 if dMs <= rM
    %fprintf('Crashed into Moon :(\n')
    value = 0;
 elseif dEs <= rE
    value = 0;
    %fprintf('Avoided Moon and Returned to Earth! :)\n')
 elseif dEs >= 1000000000
    value = 0;
    %fprintf('Flew into space! :(\n')
 else
    value = 1;
end
% Stop the integration
isterminal = 1;
% Direction
direction = 0;

end
