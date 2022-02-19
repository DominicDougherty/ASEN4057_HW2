function [hMax] = maxAlt(r, Wd, h, M)

Wair = wairCalc(r, h); %Calculate initial weight of the air and the balloon
Wt = weightCalc(r, Wd, Wair, M);

while(Wt <= Wair) %While Wt is less than Wair
    Wair = wairCalc(r, h); %And recalculate the weight of the air an balloon...
    h = h+10; %Increment h by 10 m
end

hMax = h; %The current calue of h is the max value of h

end
