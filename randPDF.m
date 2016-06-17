function [ x ] = randPDF( fun, a, b, n)
%Generate  1 x n  a vectorof random numbers following the distribution of a
%Given PDF.
%   Output:
%   x: 1 x n vector of random numbers following the distribution of fun
%   Input:
%   fun: a PDF function with compact support over [a,b]
%   a: the lower bound for the support of fun
%   b: the upper bound for the support of fun
%   n: the desired number of random values

x = zeros(1,n); % placeholder for generated numbers
filled = 0; % keeping track of the accepted values

% find ratio of area beneather pdf to box size
I = integral(fun,a,b);
f = @(x) (1/I)*fun(x);
c = max([f(a),f(b),f(fminbnd(@(x) -f(x),a,b))]);     % locate maximum
boxsize = ceil(c*(b-a));


filled = 1;
oldfill = 1;
x = zeros(1,n);
while filled < n 
    A = acceptReject(f,a,b, ((n - filled)*boxsize));
    oldfill = filled;
    filled = filled + length(A);
    if filled <= n
        x(1,oldfill:filled-1) = A;
    else
        x(1,oldfill:n) = A(1:n-oldfill+1);
    end
end

