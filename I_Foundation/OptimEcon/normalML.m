function[ML] = normalML(theta,y,x)
% NormalML(theta,y,x) calculates the likelihood function given a matrix of 
% covariates x and a dependent variable y with an unobserved stochastic
% error term which is distributed according to a normal distribution.
%
% The likelihood function is evaluated at the coefficients beta, which
% must be specified by the user.  These should include as many coefficients 
% as are to be estimated in the model, and finally an estimate of sigma.
%
% See also mle

%**************************************************************************
%*** Form stats
%**************************************************************************
N       =   length(y);
K       =   size(x,2);
sigma   =   theta(K+1);
beta    =   theta(1:K);
u       =   y - x*beta';

%**************************************************************************
%*** Likelihood function
%**************************************************************************
ML      =   -(N/2)*log(2*pi)-(N/2)*log(sigma^2)-(1/(2*sigma^2))*(u'*u);
ML      =   - ML;

return
