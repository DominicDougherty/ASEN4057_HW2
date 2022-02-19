function [dxdt] = trajectoryV2(t,x,G,ms,mM,mE)
%{
Authors: Marissa Palamara, Dominic Dougherty
trajectoryV2.m: 2nd iteration of trajectory function
date: 26 February 2022
inputs:
    t = time (s)
    x = state vector
    G = universal gravitational constant
    ms = mass of satellite (kg)
    mM = mass of Moon (kg)
    mE = mass of Earth (kg)
outputs:
    dxdt = derivative of state vector based on equations of motion
summary: function for ODE45 to find the trajectories of a satellite, the
Moon, and Earth based on their starting positions and velocities.
%}

dxdt = zeros(size(x));
% get intial vector in readable format
xs = x(1); ys = x(2); vsx = x(3); vsy = x(4);
xM = x(5); yM = x(6); vMx = x(7); vMy = x(8);
xE = x(9); yE = x(10); vEx = x(11); vEy = x(12);

%% distance calculations
dsE = distFunc(xs,ys,xE,yE); % m
dsM = distFunc(xs,ys,xM,yM); % m
dME = distFunc(xM,yM,xE,yE); % m

%% Forces
% force calculations in x direction
FsEx = ((G*ms*mE)*(xs-xE))/(dsE^3); % N
FEsx = -FsEx;
FsMx = ((G*ms*mM)*(xs-xM))/(dsM^3); % N
FMsx = -FsMx;
FMEx = ((G*mE*mM)*(xM-xE))/(dME^3); % N
FEMx = -FMEx;

% force calculations in y direction
FsEy = ((G*ms*mE)*(ys-yE))/(dsE^3); % N
FEsy = -FsEy;
FsMy = ((G*ms*mM)*(ys-yM))/(dsM^3); % N
FMsy = -FsMy;
FMEy = ((G*mE*mM)*(yM-yE))/(dME^3); % N
FEMy = -FMEy;

%% calculate x- and y-dots
% satellite
vxsdot = (FMsx+FEsx)/ms; % asx
vysdot = (FMsy+FEsy)/ms; % asy

% Moon
vxMdot = (FMEx+FsMx)/mM; % aMx
vyMdot = (FEMy+FsMy)/mM; % aMy

% Earth
vxEdot = 0; vyEdot = 0;

%% Put them all together!
dxdt(1) = vsx; dxdt(2) = vsy; dxdt(3) = vxsdot; dxdt(4) = vysdot;
dxdt(5) = vMx; dxdt(6) = vMy; dxdt(7) = vxMdot; dxdt(8) = vyMdot;
dxdt(9) = vEx; dxdt(10) = vEy; dxdt(11) = vxEdot; dxdt(12) = vyEdot;
