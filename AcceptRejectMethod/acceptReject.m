function [A,varargout] = acceptReject(fun,a,b,n,varargin)
% ACCEPTREJECT  Produces random variables with accept/reject method.
%
%   Examples:
%       f = @(x) 6 * x.^2 .* (1-x).^2;
%       A = acceptReject(f, -1, 1, 1e4);
%
%       This takes function f, left and right endpoints a = -1, b = 1
%       with n = 1e4 trials; returns numerical array A containing the
%       accepted X-values (i.e., the values of the random variable with
%       density function f).
%   ------------------------------------------------------------------
%
%       f = @(x) 6 * x.^2 .* (1-x).^2;
%       [A,Xc,Yc] = acceptReject(f, -1, 1, 1e4);
%
%       The optional output arguments Xc and Yc return cell arrays:
%       The first rows Xc{1,:} and Yc{1,:} contain the accepted x- and 
%       y-values, respectively. The second rows Xc{2,:} and Yc{2,:} contain
%       the rejected values.
%   ------------------------------------------------------------------
%
%       A = acceptReject(f, -1, 1, 1e4,'plot');
%
%       The optional input string 'plot' returns a histogram comparing the
%       produced values with the actual user-specified density.

% Scale density function to appropriate size.
I = integral(fun,a,b); 
f = @(x) (1/I)*fun(x);
c = max([f(a),f(b),f(fminbnd(@(x) -f(x),a,b))]);     % locate maximum
M = @(x) c + (x-x);

% Initialize random variables for n trials.
T = (b-a)*rand(1,n)+a;          % x-value uniform distribution on S
U = rand(1,n);                  % y-scale factor uniform distribution

% Test criteria.
TEST = [ U .* M(T) <= f(T) ];     % logic array (0 if reject, 1 if accept)

Xc = {T(TEST); ...       % row 1 <- accepted X values
      T(~TEST)};         % row 2 <- rejected X values
                              
Yc = {U(TEST).*c; ...    % row 1 <- accepted Y values
      U(~TEST).*c};      % row 2 <- rejected Y values

A = Xc{1,:};             % accepted X values as num array

% Report accepted/rejected data if requested.
varargout{1} = Xc;   varargout{2} = Yc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% Optional Routines
if ~isempty(varargin)
    switch varargin{1}
        case 'plot'     % Plotting routine
            acceptRejectPlot(fun,a,b,Xc,Yc)
    end
end