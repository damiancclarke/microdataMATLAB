function Loss  = CournotLoss(q, a, b, ci, cj)
%------------------------------------------------
% PURPOSE: returns the quadratic loss for a
% simple Cournot model.
%------------------------------------------------
% INPUTS:  q : [q(1); q(2)]
%          ci : MC for i
%          cj : MC for j
%          a : intercept
%          b : slope
%------------------------------------------------
% OUTPUT: Loss : deviation from best response
%------------------------------------------------

qi_star = BestResponse(q(2), ci, a, b);
qj_star = BestResponse(q(1), cj, a, b);

Loss = (q(1) - qi_star)^2 + (q(2) - qj_star)^2;

return
