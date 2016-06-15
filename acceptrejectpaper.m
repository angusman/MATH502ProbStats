%% The Accept Reject Method: Anthony Gusman, Nicholas Sullivan

%% Introduction
% The process of generating pseudo random numbers using a given cumlative
% density function of a random variable is easy if the inverse of the CDF
% is known or quick to find, the general method breaks down when there does
% not exist a happy way to find the inverse of the CDF. This is why we will
% be exploring something called the Acceptance-Rejection Method.


%% Overview of Method
% The Acceptance-Rejection Method is actaully quite simple, the method as implemented by our acceptreject function in plain
% english is described below:
%%
% # Given a probability densitity function (*PDF*) $f_X$ of a random
% variable X with compact support find its maximum over its range (c).
% # generate a pair of random numbers (X,Y) such that X $\sim$ U[support
% of $f_X$] and Y $\sim$ U[0,c]
% # for each point ($x_i$, $y_i$) if 0 $\leq y_i \leq f_X(x_i)$ then it is
% "accepted" otherwise it is "rejected"
%%
% As you can see this is essentially the same process used in Monte-Carlo
% integration.


%% The Functions
% We provide two functions in this paper, acceptReject.m and
% acceptRejectPlot.m with the following outputs and arguments:
%%
% [X,Y] = acceptReject(f,a,b,n)
%%
% * *Output:* [X,Y], random numbers defined as above split into a cell with the first
% row as the accepted values and the second row as the rejected values
% * *Input:* f, PDF function $f_X$
% * a, lower bound of f's range
% * b, upper bound of f's range
% * n, number of $(x_i, y_i)$ pairs (increase this for higher accuracy)
%%
% acceptRejectPlot(fun,a,b,Xc,Yc)
%%
% * *Output:* plots, one of the pdf with a histogram of the accepted number
% generated and one of the pdf along with all accepted and rejected points.
% * *Input:* fun, PDF function $f_X$
% * a, lower bound of fun's range
% * b, upper bound of fun's range
% * Xc, the X returned by acceptReject
% * Yc, the Y returned by acceptReject
%% Accept Reject and Plotter function code
% here is the full code of both functions with comments and syntax high
% lighting:
% *acceptReject.m*
%%
% <include>acceptReject.m</include>
%%
% *acceptRejectPlot.m*
%%
% <include>acceptRejectPlot.m</include>


%% Examples
% Lets do the beta and someother unhappy distribution

%% Full function code