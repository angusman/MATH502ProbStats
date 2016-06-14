function acceptRejectPlot(fun,a,b,Xc)
% ACCEPTREJECTPLOT  Plots results from acceptReject output.
%
%   Example:
%       f = @(x) 6 * x.^2 .* (1-x).^2;
%       [X,Y] = acceptReject(f,-1,1,1e4);
%
%       acceptRejectPlot(f, -1, 1, X);
%
%       This plots the approximate density using the histogram of X and the
%       actual density f.

% Recover data
I = integral(fun,a,b); 
f = @(x) (1/I)*fun(x);

X = Xc{1,:};    notX = Xc{2,:};
n = length(X) + length(notX);

nACCEPT = length(X);            % count how many we accepted (stats)
pACCEPT = nACCEPT/n;            % percentage accepted (stats)

% Plot the approximate and actual density.
figure(1)

m = 50;                                 % number of bins
EDGES = linspace(a,b,m);                % define bins for histogram
FREQ = histc(X,EDGES);                  % report frequency in each bin
A = nACCEPT*(b-a)/(m-1);                % 'area' of histogram
approx = bar(EDGES,FREQ/A,'histc');     % plot approximate density

hold on

x = linspace(a,b,200);              % domain for actual density
plot(x,f(x),'r--','LineWidth',2);   % plot actual density
    
xlabel('x'); ylabel('f(x)'); title('Accept/Reject Method');
set(approx,'FaceColor',[1 1 1],'LineWidth',2);