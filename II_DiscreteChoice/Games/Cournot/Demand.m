function price = Demand(q, a, b)

% This returns the inverse demand for a simple Cournot model.

price   = max(0, a - b * q);

return