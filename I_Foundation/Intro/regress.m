function [beta, se] = regress(y,x)
% regress(y, x) runs a multi-linear regression of the n*k matrix 
% of (k) independent variables, on the dependent variable y (an n*1 
% vector).  regress returns a parameter vector of coefficients 
% called beta and se.


%******************************************************************************%
%*** (1) Calculate the coefficients
%******************************************************************************%
beta=inv(x'*x)*x'*y; %version 1: matrix algebra
%beta = (X'*X)\(X'*y) % version 2: introducing MATLAB's backslash (mldivide)
%beta = X\y % version 3: taking full advantage of MATLAB's inbuilt operations


%******************************************************************************%
%*** (2) Calculate the standard errors
%******************************************************************************%
yhat = x*beta;
u = yhat - y;
N = length(y);
K = size(x);
sigma = sum(u.*u)/(N-K(2));
v_mat = sigma * inv(x'*x); % Variance-covariance matrix for estimators
se = diag(sqrt(v_mat)); % vector of standard errors of estimates

return
