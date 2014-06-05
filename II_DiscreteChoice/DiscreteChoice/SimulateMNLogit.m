function y = SimulateMNLogit(x, betavec)

N           = size(x, 1);
K           = size(x, 2);
J           = size(betavec, 1)/K + 1;

beta        = reshape(betavec, K, J - 1);

% First, simulate values for epsilon...

epsilon     = -log(-log(rand(N, J)));;

% Second, simulate the utility for two options...

beta_augmented  = [beta, zeros(K, 1)];
utility         = x * beta_augmented + epsilon;

% Third, simulate the choice for each individual...

[junk, y]       = max(utility, [], 2);

% GraphSimulatedData(utility, y)

return