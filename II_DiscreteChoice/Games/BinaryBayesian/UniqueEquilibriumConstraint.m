function [c, ceq] = UniqueEquilibriumConstraint(parameters)

delta_1     = parameters(3);
delta_2     = parameters(4);
rho         = parameters(5);

c           = [ -sqrt(pi/2) * sqrt((1 - rho) / (1 + rho)) - delta_1; ...
                -sqrt(pi/2) * sqrt((1 - rho) / (1 + rho)) - delta_2];
ceq         = [];

return