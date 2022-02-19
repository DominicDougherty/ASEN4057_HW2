function [Wt] = weightCalc(r, Wd, Wair, M)

rho0 = 1.225; %Pre-defined air density at sea level

Wgas = (4/3)*pi*rho0*(r^3)*(M/28.966); % Calculate weight of the gas

Wt = Wd + Wgas + Wair; %Calculate the total weight of the balloon


end
