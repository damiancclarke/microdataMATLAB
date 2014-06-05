function y = SimulateBinaryLogit(x, beta)

% This function returns a binary outcome, simulating a logit model.

N           = size(x, 1);
J           = 2;

% First, simulate values for epsilon...

epsilon     = -log(-log(rand(N, J)));;

% Second, simulate the utility for two options...

beta_augmented  = [beta, 0 * beta];
utility         = x * beta_augmented + epsilon;

% Third, simulate the choice for each individual...

[junk, choice]  = max(utility, [], 2);
y               = (choice == 1);

return