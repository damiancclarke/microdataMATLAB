function [LL, ll_i] = ...
BinaryLogitSimulatedLL(Beta, y, x, R)
%------------------------------------------------
% PURPOSE: calculate simulated likelihood
%------------------------------------------------
% INPUTS: Beta : Kx1 parameter vector
%         y : Nx1 vector of dependent variable
%         x : NxK matrix of independent variables
%         R : scalar replications
%------------------------------------------------
% OUTPUT: LL : scalar log likelihood
%         ll_i : log-likelihood contribution of
%                observations
%------------------------------------------------

%----- (1) Seed and set up initial vectors ------
rng(1);
N            = size(y, 1);
Simulated_y  = NaN(N, R);

%----- (2) Create R simulated realizations ------
for count = 1:R
    Simulated_y(:, count) =...
              SimulateBinaryLogit(x, Beta);
end
SimProb  = mean(Simulated_y, 2);

%----- (3) Calculate log-likelihood -------------
ll_i = y .* log(SimProb)+(1-y).* log(1-SimProb);
LL   = -sum(ll_i);

return
