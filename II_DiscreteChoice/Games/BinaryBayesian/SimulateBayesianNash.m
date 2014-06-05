function [y, x]  = SimulateBayesianNash(M, mu_1, mu_2, beta_1, beta_2, rho);

% This function simulates data from the Bayesian Nash model.

rng(1)

% First, simulate the covariate (x), and generate the values for (mu_i,
% mu_j).

x       = round(rand(M, 2));

% Second, simulate by solving the game for each value x...

cutoffs = NaN(M, 2);
y       = NaN(M, 2);

for count = 1:M
    count
    cutoffs(count, :)   = SolveBayesianNash(mu_1, mu_2, ...
                            beta_1 * x(count, 1), beta_2 * x(count, 2), rho);
    y(count, :)         = mvnrnd([mu_1, mu_2], [1, rho; rho, 1], 1) > cutoffs(count, :);
end

return