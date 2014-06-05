function Loss = BestResponseLoss(x_i, mu_i, x_j, mu_j, rho, delta_i)

% This function returns the loss for player i's best response.

Loss    = (x_i - delta_i * (2 * norm_cdf((x_j - mu_j - rho * (x_i - mu_i))/sqrt(1 - rho^2)) - 1))^2;

return