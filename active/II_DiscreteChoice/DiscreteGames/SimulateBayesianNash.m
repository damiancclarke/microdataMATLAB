function [a,z,nm] = ...
  SimulateBayesianNash(M,g_1,g_2,b_1,b_2,rho);
%------------------------------------------------
% PURPOSE: simulates data from the Bayesian Nash
%          model.
%------------------------------------------------
% INPUTS:  M : total markets
%          g_1 : gamma 1 (parameter)
%          g_2 : gamma 2 (parameter)
%          b_1 : beta 1 (parameter)
%          b_2 : beta 2 (parameter)
%          rho : signal correlation (parameter)
%------------------------------------------------
% OUTPUT:  a : advertising strategy choice
%          z : binary covariate
%          nm : market size
%------------------------------------------------
rng(1)

%--- First, simulate the covariates (z and p).---
z    = randi([0, 1], M, 2);
nm   = randi([0, 10], M, 1)/ 10;

%---- Second, simulate by solving the game for
%     each market...----
cutoffs = NaN(M, 2);
a       = NaN(M, 2);

for count = 1:M
    count
    cutoffs(count, :) =  SolveBayesianNash(g_1 * nm(count),...
                      g_2 * nm(count),...
                      b_1 * z(count, 1),...
                      b_2 * z(count, 2),...
                      rho);
    a(count, :) = mvnrnd([g_1 * nm(count),...
                          g_2 * nm(count)],...
                         [1, rho; rho, 1], 1) > ...
                          cutoffs(count, :);
end

return
