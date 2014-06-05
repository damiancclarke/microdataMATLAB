function x_i_star   = SolveBestResponse(mu_i, x_j, mu_j, rho, delta_i)

% This function returns the best response for player i against player j.

options     = optimset('Algorithm', 'sqp', 'Display', 'off', 'TolFun', 1e-3);
x_i_star    = fmincon(@(x_i) BestResponseLoss(x_i, mu_i, x_j, mu_j, rho, delta_i), ...
                0, [], [], [], [], -10, 10, [], options);


return