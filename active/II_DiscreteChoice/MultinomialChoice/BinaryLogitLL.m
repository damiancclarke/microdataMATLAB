function [LL, ll_i] = BinaryLogitLL(Beta, y, x)

%------------------------------------------------
% PURPOSE: Calculate the log-likelihood for the
% binary logit
%------------------------------------------------
% INPUTS: Beta : Kx1 parameter vector
%         y : Nx1 vector of dependent variable
%         x : NxK matrix of independent variables
%------------------------------------------------
% OUTPUT: LL : scalar log likelihood
%         ll_i : log-likelihood contribution of
%                observations
%------------------------------------------------

Lambda_xb = exp(x * Beta)./(1 + exp(x * Beta));

ll_i      =        y  .* log(Lambda_xb) ...
            + (1 - y) .* log(1 - Lambda_xb);

LL        = -sum(ll_i);

return
