function acceptRejectPlot(fun,a,b,Xc,Yc)
% ACCEPTREJECTPLOT  Plots results from acceptReject.
%
%   Example:
%       f = @(x) 6 * x.^2 .* (1-x).^2;
%       [A,Xc,Yc] = acceptReject(f,-1,1,1e4);
%
%       acceptRejectPlot(f, -1, 1, Xc, Yc);
%
%       This plots the approximate density using the histogram of Xc and 
%       the actual density f. A second plot contains some sample 
%       accept/reject points.

% Recover data
I = integral(fun,a,b); 
f = @(x) (1/I)*fun(x);

X = Xc{1,:};    notX = Xc{2,:};
n = length(X) + length(notX);

nACCEPT = length(X);            % count how many we accepted (stats)
pACCEPT = nACCEPT/n;            % percentage accepted (stats)

% Plotting
x = linspace(a,b,200);              % domain for actual density

% Plot some sample accept/reject points.
figure(1)

hold on

nEnd = min([.5e4,length(Xc{1,:})]);
nEnd2 = min([.5e4,length(Xc{2,:})]);

plot(Xc{1,:}(1:nEnd),Yc{1,:}(1:nEnd),'b+')
plot(Xc{2,:}(1:nEnd2),Yc{2,:}(1:nEnd2),'rx')

plot(x,f(x),'k--','LineWidth',2);   % plot actual density
xlabel('x'); ylabel('f(x)'); title('Sample Points');

% Plot the approximate and actual density.
figure(2)

m = 50;                                 % number of bins
EDGES = linspace(a,b,m);                % define bins for histogram
FREQ = histc(X,EDGES);                  % report frequency in each bin
A = nACCEPT*(b-a)/(m-1);                % 'area' of histogram
approx = bar(EDGES,FREQ/A,'histc');     % plot approximate density

hold on

plot(x,f(x),'r--','LineWidth',2);   % plot actual density
    
xlabel('x'); ylabel('f(x)'); title('Accept/Reject Method');
set(approx,'FaceColor',[1 1 1],'LineWidth',2);