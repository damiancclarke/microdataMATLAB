function Loss = BayesianNashLoss(x, mu_i, mu_j, delta_i, delta_j, rho)

xi_star = SolveBestResponse(mu_i, x(2), mu_j, rho, delta_i);
xj_star = SolveBestResponse(mu_j, x(1), mu_i, rho, delta_j);

Loss    = (x(1) - xi_star)^2 + (x(2) - xj_star)^2;

return