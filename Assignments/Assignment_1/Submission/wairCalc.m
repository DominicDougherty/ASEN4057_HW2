function [Wair] = wairCalc(r, h)

if(h <= 11000) %If h is within 0 to 11000 use these equations
    T = 15.04 - 0.00649*h;
    P = 101.29*(((T+273.1)/288.08)^5.256);
elseif(h <= 25000) %If h is within 11000 to 25000 use these equations
    T = -56.46;
    P = 22.65*(exp(173 - 0.000157*h));
elseif(h>25000) %If h is greater than 25000 use these equations
    T = -131.21 + 0.00299*h;
    P = 2.488*(((T+273.1)/216.6)^(-11.388));
end

rho = P/(0.2869*(T+273.1)); %Calculate rho at the given altitude

Wair = (4/3)*pi*rho*(r^3); %Calculate the weight of the air at the given altitude

end
