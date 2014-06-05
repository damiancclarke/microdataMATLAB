% RunBinaryBayesian

clear
cla

% Initialise the parameters...

mu_i        = 1;
mu_j        = -1;

rho         = 0.75

delta_i     = -0.5;
delta_j     = -0.5;

% Generate a grid for x_j...

x_j  = [-5:.1:5]';

% Solve the best response for x_i...

x_i_star    = NaN(size(x_j));

for count = 1:size(x_i_star, 1)
    x_i_star(count, 1) =  SolveBestResponse(mu_i, x_j(count, 1), mu_j, rho, delta_i);
end

line(x_j, x_i_star, 'LineWidth', 2, 'Color', [1, 0, 0])

% Generate a grid for x_i...

x_i  = [-5:.1:5]';

% Solve the best response for x_j...

x_j_star    = NaN(size(x_i));

for count = 1:size(x_i_star, 1)
    x_j_star(count, 1) =  SolveBestResponse(mu_j, x_i(count, 1), mu_i, rho, delta_j);
end

hold on
line(x_j_star, x_i, 'LineWidth', 2, 'Color', [0, 0, 1])

% Solve the model...

BayesianNash    = SolveBayesianNash(mu_i, mu_j, delta_i, delta_j, rho);

hold on
scatter(BayesianNash(2), BayesianNash(1), 100, [0, 0, 0], 'filled')

% Simulate...

mu_1            = 1;
mu_2            = -1;
beta_1          = -0.2;
beta_2          = -0.7;
rho             = 0.5;

[y, x]          = SimulateBayesianNash(1000, mu_1, mu_2, beta_1, beta_2, rho);

return

% Estimate....

parameters_init     = [mu_1, mu_2, beta_1, beta_2, rho]';

lb                  = [-2, -2, -2, -2, 0];
ub                  = [2, 2, 0, 0, 0.99];

options             = optimset('Algorithm', 'sqp', 'Display', 'iter', 'DiffMinChange', 1e-4);

[result.parameters, result.LL, result.exitflag] = ...
        fmincon(@(parameters) BayesianNashLL(parameters, y, x), parameters_init, ...
            [], [], [], [], lb, ub, @(parameters) UniqueEquilibriumConstraint(parameters), options);

[parameters_init, result.parameters]
        
return