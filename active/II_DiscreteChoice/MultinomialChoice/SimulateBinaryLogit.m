function [y,utility]=SimulateBinaryLogit(x,Beta)
%------------------------------------------------
% PURPOSE: generate binary outcomes according to
% the logit specification.
%------------------------------------------------
% INPUTS: x : NxJ vector of independent variable
%         Beta : Jx1 parameter vector
%------------------------------------------------
% OUTPUT: y : N-by-1 binary choice vector
%------------------------------------------------

N    = size(x, 1);
J    = length(Beta);

%----- (1) simulate values for epsilon&, based on
%          this, utility ----
epsilon         = -log(-log(rand(N, J)));
Beta_augmented  = [Beta, 0 * Beta];
utility         = x * Beta_augmented + epsilon;

%----- (2) simulate the choice for each
%          individual ------
[~, choice]     = max(utility, [], 2);
y               = (choice == 1);

return
