% acceptRejectRoutine
clear all; close all
f = @(x) 0.5^2.75 / gamma(2.75) * x.^(1.75) .* exp(-0.5*x);
a = 0; b = 15; n = 1e5;

%%%%%%%%%% SET THIS TO DESIRED DEMO # %%%%%%%%%%%
option = 4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch option
    case 1      % No plot produced, only accepted vals
        A = acceptReject(f,a,b,n);
        
    case 2      % No plot produced, accepted/rejected X
        [A,Xc] = acceptReject(f,a,b,n);
        
    case 3      % No plot produced, all accept/reject data
        [A,Xc,Yc] = acceptReject(f,a,b,n);
        
    case 4      % Plot produced, then case 1
        A = acceptReject(f,a,b,n,'plot');
        
    case 5      % Plot produced, then case 2
        [A,Xc] = acceptReject(f,a,b,n,'plot');
        
    case 6      % Plot produced, then case 3
        [A,Xc,Yc] = acceptReject(f,a,b,n,'plot');
end