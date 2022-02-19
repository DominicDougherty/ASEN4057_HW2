function f = optFunc(deltavs,xs0,ys0,vs0,xM0,yM0,vMx0,vMy0,xE0,yE0,vEx0,vEy0,rE,thetas,G,ms,mM,mE)
%{
Authors: Marissa Palamara, Dominic Dougherty
optFunc.m
date: 26 February 2022
inputs:
   
outputs:
    
summary: 
%}

vs0 = vs0+deltavs; % m/s - initial speed
vsx0 = vs0*cos(thetas); % m/s
vsy0 = vs0*sin(thetas); % m/s

options = odeset('Events',@myeventsOpt1,'RelTol',1e-8);
tspan = [0 1e10];
y0 = [xs0,ys0,vsx0,vsy0,xM0,yM0,vMx0,vMy0,xE0,yE0,vEx0,vEy0]; 

[T,Y,TE,YE,IE] = ode45(@(t,y) trajectoryV2(t,y,G,ms,mM,mE),tspan,y0,options);

f = distFunc(YE(1),YE(2),YE(9),YE(10))-rE;
end
