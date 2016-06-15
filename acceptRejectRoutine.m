% acceptRejectRoutine
clear all; close all
f = @(x) 0.5^2.75 / gamma(2.75) * x.^(1.75) .* exp(-0.5*x);
a = 0; b = 15; n = 1e5;

[X,Y] = acceptReject(f,a,b,n);
acceptRejectPlot(f,a,b,X,Y)
