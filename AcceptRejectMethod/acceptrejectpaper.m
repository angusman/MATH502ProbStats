%% The Accept-Reject Method: Anthony Gusman, Nicholas Sullivan

%% Introduction
% The process of generating pseudo random numbers using a given density 
% function of a random variable is easy if the inverse of the CDF
% is known or quick to find. However, the general method breaks down when 
% there does not exist a happy way to find the inverse of the CDF. This is 
% why we will be exploring something called the _Acceptance-Rejection Method_.


%% Overview of Method
% The Acceptance-Rejection Method is actually quite simple. We implement the 
% method with our |acceptReject| function as described in plain
% English below:
%%
% # Given a probability density function (*PDF*) $f_X$ of a random
% variable $X$ with compact support find its maximum over its range (call it $c$).
% # Generate a pair of random numbers $(X,Y)$ such that $X \sim U[support$  
% $of f_X]$ and $Y \sim U[0,c]$.
% # For each point $(x_i, y_i)$ if $0 \leq y_i \leq f_X(x_i)$ then it is
% "accepted" otherwise it is "rejected."
%%
% As you can see this is essentially the same process used in Monte-Carlo
% integration.


%% The Functions
% We provide three functions in this paper, |acceptReject.m|, 
% |acceptRejectPlot.m| and |randPDF.m| with the following outputs and arguments:
%%
% |[A,varargout] = acceptReject(fun,a,b,n,varargin)|
%%
% * *Output:* numerical array A containing the accepted X-values (i.e., the
% values of the random variable with  density function f).
% * *Input:* fun, PDF function $f_X$
% * a, lower bound of fun's domain
% * b, upper bound of fun's domain
% * n, number of $(x_i, y_i)$ pairs (increase this for higher accuracy)
% * The optional input string 'plot' returns a histogram comparing the
% produced values with the actual user-specified density. 
%%
% |acceptRejectPlot(fun,a,b,Xc,Yc)|
%%
% * *Output:* plots, one of the pdf with a histogram of the accepted values
% generated and one of the pdf along with accepted and rejected points.
% * *Input:* fun, PDF function $f_X$
% * a, lower bound of fun's domain
% * b, upper bound of fun's domain
% * X, the X returned by |acceptReject|
% * Y, the Y returned by |acceptReject|
% *Note:* This will have little use aside from its call by |acceptReject.m|
%%
% |[x] = randPDF( fun, a, b, n)|
%%
% * *Output:* a 1xn vector of random values with density provided by fun
% * *Input:* fun, PDF function $f_X$
% * a, lower bound of fun's domain
% * b, upper bound of fun's domain
%% Accept Reject and Plotter function code
% here is the full code of all functions with comments and syntax high
% lighting:
%%
% *acceptReject.m*
%%
% <include>acceptReject.m</include>
%%
% *acceptRejectPlot.m*
%%
% <include>acceptRejectPlot.m</include>
%% 
% *randPDF.m*
%%
% <include>randPDF.m</include>


%% Example of the inside work with the Beta Density
% Lets take a look at how these functions work using the beta density with
% a = 6 and b = 2
% 
%%
% setting up a, b and beta(u)
a = 6;
b = 2;
beta = @(u) gamma(a+b)/(gamma(a)*gamma(b)) * u.^(a-1) .* (1-u).^(b-1);

%%
% Plotting to see the pdf

x = linspace(0,1,1000);

figure
hold on
title('The Beta Density with a = 6, b = 2')
plot(x,beta(x))
xlabel('u')
ylabel('f(u)')
hold off
%%
% Now lets test out the functions for 10,000 points
[A] = acceptReject(beta,0,1,10000,'plot');

%% Example 10000 points with density of the Beta distribution
% All random number generators out there work in the following manner, a
% type of random number is chosen via which rand function is used (|rand|,
% |randi|, ...) and then the user specifies how they want that data
% returned, a vector, a single random number or a matrix.
%
% randPDF works much in the same manner, though with slightly limmited
% functionality at this time. given a function a range and a number of
% points to be returned randPDF generates that number of points required
% from the density given.
%
% lets try it out using the beta density above and grabbing 10000 points.

n = 10000;

x = randPDF(beta, 0, 1, n);

figure
hold on
title('histogram of 10000 points generated from a beta density')
histogram(x,50)
hold off