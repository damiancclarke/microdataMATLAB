function y  = Profit(qi, qj, ci, a, b)

% This function returns profit for a simple Cournot model.

y   = (Demand(qi + qj, a, b) - ci) * qi;

return