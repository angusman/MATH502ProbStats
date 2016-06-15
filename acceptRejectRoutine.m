% acceptRejectRoutine
clear all
f = @(x) 6*x.^2 .*(1-x).^2;
a = -1; b = 1; n = 1e4;

[X,Y] = acceptReject(f,a,b,n);
acceptRejectPlot(f,a,b,X)


