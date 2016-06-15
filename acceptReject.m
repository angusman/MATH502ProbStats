function [Xc,Yc] = acceptReject(fun,a,b,n)
% ACCEPTREJECT  Simulates random variables with scaled density.
%
%   Example:
%       f = @(x) 6 * x.^2 .* (1-x).^2;
%       [X,Y] = acceptReject(f, -1, 1, 1e4);
%
%       This takes function f, left and right endpoints a = -1, b = 1
%       with n = 1e4 trials; returns cell arrays X and Y. The first rows 
%       X{1,:} and Y{1,:} contain the accepted x- and y-values,
%       respectively. The second rows X{2,:} and Y{2,:} contain the
%       rejected values.

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