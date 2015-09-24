function Nash = SolveCournotNash(a, b, ci, cj)
%------------------------------------------------
% PURPOSE: solves the Nash for a simple Cournot
%          model.
%------------------------------------------------
% INPUTS:   ci : MC for i
%           cj : MC for j
%           a : intercept
%           b : slope
%------------------------------------------------
% OUTPUT:  Nash : quantites at equilibrium
%------------------------------------------------

opts = optimset('Algorithm', 'sqp', 'Display', ...
                 'off');
Nash =  fmincon(@(q) CournotLoss(q, a, b, ci,...
        cj), [0, 0], [], [], [], [], [0, 0],...
        [], [], opts)

return
