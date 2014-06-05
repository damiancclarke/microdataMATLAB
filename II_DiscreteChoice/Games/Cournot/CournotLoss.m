function Loss   = CournotLoss(q, a, b, ci, cj)

% This returns the quadratic loss for a simple Cournot model.
% It is minimised at zero at the Nash.

qi_star         = BestResponse(q(2), ci, a, b);
qj_star         = BestResponse(q(1), cj, a, b);

Loss            = (q(1) - qi_star)^2 + (q(2) - qj_star)^2;

return