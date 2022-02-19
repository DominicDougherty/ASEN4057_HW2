%Simple script to plot the results of the bistatic processing of the
%direct channel;  create two figures and plot important aspects
function [] =  plotresults(app, e_i,e_q,p_i,p_q,l_i,l_q,carrierfq,codefq)

x = 1:length(p_i);

plot(app.UIAxes_3, x, p_i .^2 + p_q .^ 2, 'g.-', x, e_i .^2 + e_q .^ 2, 'bx-', x, l_i .^2 + l_q .^ 2, 'r+-')
hold on
grid(app.UIAxes_3, 'on');
%plot(app.UIAxes_3, e_i .^2 + e_q .^ 2, 'bx-')
%plot(app.UIAxes_3, l_i .^2 + l_q .^ 2, 'r+-')
hold off
xlabel(app.UIAxes_3,'milliseconds')
ylabel(app.UIAxes_3,'amplitude')
title(app.UIAxes_3,'Correlation Results')
legend(app.UIAxes_3,'prompt','early','late')
plot(app.UIAxes,p_i)
grid(app.UIAxes, 'on');
xlabel(app.UIAxes,'milliseconds')
ylabel(app.UIAxes,'amplitude')
title(app.UIAxes,'Prompt I Channel')
plot(app.UIAxes_2, p_q)
grid(app.UIAxes_2, 'on');
xlabel(app.UIAxes_2,'milliseconds')
ylabel(app.UIAxes_2,'amplitude')
title(app.UIAxes_2,'Prompt Q Channel')

plot(app.UIAxes2, 1.023e6 - codefq)
grid(app.UIAxes2, 'on');
xlabel(app.UIAxes2,'milliseconds')
ylabel(app.UIAxes2,'Hz')
title(app.UIAxes2,'Tracked Code Frequency (Deviation from 1.023MHz)')
plot(app.UIAxes3, carrierfq)
grid(app.UIAxes3, 'on');
xlabel(app.UIAxes3,'milliseconds')
ylabel(app.UIAxes3,'Hz')
title(app.UIAxes3,'Tracked Intermediate Frequency')
end

