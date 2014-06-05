function BayesianNash   = SolveBayesianNash(mu_i, mu_j, delta_i, delta_j, rho)

options         = optimset('Algorithm', 'sqp', 'Display', 'off', 'TolFun', 1e-4);
BayesianNash    = fmincon(@(x) BayesianNashLoss(x, mu_i, mu_j, delta_i, delta_j, rho), ...
                    [0, 0], [], [], [], [], [-10, -10], [10, 10], [], options);
return