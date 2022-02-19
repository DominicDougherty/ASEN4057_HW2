clc; close all; clear;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Dominic Dougherty, Marissa Palamara
% ASEN 4057
% 1/20/2022
% Homework 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Get the ODE45 working!
%% Constants
G = 6.674*10^(-11); % N(m/kg)^2
% Satellite
ms = 28833; % kg
% Moon
mM = 7.34767309*10^(22); % kg
rM = 1737100; % m
% Earth
mE = 5.97219*10^(24); % kg
rE = 6371000; % m

%% Initial Conditions
% Satellite
dEs = 340*10^6; % m
thetas = deg2rad(50); % rad
vs0 = 1000; % m/s - initial speed
xs0 = dEs*cos(thetas); % m
ys0 = dEs*sin(thetas); % m
vsx0 = vs0*cos(thetas); % m/s
vsy0 = vs0*sin(thetas); % m/s

% Moon
dEM = 384403000; % m
thetaM = deg2rad(42.5); % rad
vM0 = sqrt((G*(mE^2))/((mE+mM)*dEM)); % m/s - initial speed
xM0 = dEM*cos(thetaM); % m
yM0 = dEM*sin(thetaM); % m
vMx0 = -vM0*sin(thetaM); % m/s
vMy0 = vM0*cos(thetaM); % m/s
% Earth
xE0 = 0; % m
yE0 = 0; % m
vEx0 = 0; % m/s
vEy0 = 0; % m/s 

% Initial Vector
y0 = [xs0,ys0,vsx0,vsy0,xM0,yM0,vMx0,vMy0,xE0,yE0,vEx0,vEy0];
tspan = [0 1e5]; % s
dMs0 = distFunc(xs0,ys0,xM0,yM0);

%% ODE45 Call
options = odeset('Events',@myevents,'RelTol',1e-8);
[T,Y,TE,YE,IE] = ode45(@(t,y) trajectoryV2(t,y,G,ms,mM,mE),tspan,y0,options);
xs = Y(:,1); ys = Y(:,2);
xM = Y(:,5); yM = Y(:,6);
xE = Y(:,9); yE = Y(:,10);

fprintf('The Moon and Satellite collide when center of Moon is at [%0.2d,%0.2d] m and %0.1f s relative to Earth.\n', ...
    xM(end),yM(end),T(end))

%% Plot collision if no avoidance taken
% figure
% % plot satellite trajectory
% plot(xs,ys)
% hold on
% 
% % plot Moon trajectory
% plot(xM,yM)
% % plot Moon
% ang = linspace(0,2*pi);
% xMoon = rM*cos(ang)+xM(end);
% yMoon = rM*sin(ang)+yM(end);
% plot(xMoon,yMoon,'Color',[0.3 0.3 0.3])
% 
% % xlim([2.15*10^8 2.9*10^8])
% % ylim([2.15*10^8 2.9*10^8])
% legend('Satellite Trajectory','Moon Trajectory','Moon','Location','south')
% title('Moon and Satellite About to Collide! (no initial change in velocities)')
% xlabel('x-coordinate (m)')
% ylabel('y-coordinate (m)')

%% Objective 1
%{
Find the smallest change in initial velocity which will guarantee the 
spacecraft will make it safely back to Earth. In addition, plot the 
resulting spacecraft trajectory as it slingshots around the moon and 
returns to Earth, and explain the procedure as to how you arrived at the 
smallest change in initial velocity.
%}

for i= 1:1:100
% initial guess for delta_vsx/y
deltavs0 = i; % m/s

% desired condition of satellite missing Moon
dsM_min = rM+1; % subject to change

deltavs(i) = fminsearch(@(deltavs)optFunc(deltavs,xs0,ys0,vs0,xM0,yM0,vMx0,vMy0,xE0,yE0,vEx0,vEy0,rE,thetas,G,ms,mM,mE),deltavs0);

end

[~, imin] = min(abs(deltavs));
deltavmin = deltavs(imin(1));

vs0 = vs0+deltavmin; % m/s - initial speed
vsx0 = vs0*cos(thetas); % m/s
vsy0 = vs0*sin(thetas); % m/s
% Initial Vector
y0 = [xs0,ys0,vsx0,vsy0,xM0,yM0,vMx0,vMy0,xE0,yE0,vEx0,vEy0];
tspan = [0 1e10]; % s
%% ODE45 Call
options = odeset('Events',@myeventsOpt1,'RelTol',1e-8);
[T,Y,TE,YE,IE] = ode45(@(t,y) trajectoryV2(t,y,G,ms,mM,mE),tspan,y0,options);
xs = Y(:,1); ys = Y(:,2);
xM = Y(:,5); yM = Y(:,6);
xE = Y(:,9); yE = Y(:,10);

%% Plot return to Earth with min deltavs
figure
% plot satellite trajectory
plot(xs,ys)
axis([-7e8 7e8 -1e8 7e8])
grid on
hold on

% plot Moon trajectory
plot(xM,yM)
% plot Moon
ang = linspace(0,2*pi);
xMoon = rM*cos(ang)+xM(end);
yMoon = rM*sin(ang)+yM(end);
plot(xMoon,yMoon,'Color',[0.3 0.3 0.3])
hold on
%plot Earth
xEarth = rE*cos(ang) + xE(end);
yEarth = rE*sin(ang) + yE(end);
plot(xEarth,yEarth,'Color',[0.3 0.3 0.3])

legend('Satellite Trajectory','Moon Trajectory','Moon','Location','south')
title('Spacecraft Returns to Earth with min DeltaV')
xlabel('x-coordinate (m)')
ylabel('y-coordinate (m)')

tend = TE/3600;
fprintf('The Spacecraft returns to Earth in %0.2d hours, using a %0.1f m/s deltaV maneuver.\n', ...
    tend, deltavmin)

