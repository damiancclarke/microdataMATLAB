function Nash = SolveNash(a, b, ci, cj)

% This solves the Nash for a simple Cournot model.

options     = optimset('Algorithm', 'sqp', 'Display', 'off', 'TolX', 1e-5, 'MaxFunEvals', 2000);
[Nash, Loss, exitflag]        = fmincon(@(q) CournotLoss(q, a, b, ci, cj), [0, 0], [], [], [], [], [0, 0], [], [], options);

Loss
exitflag

return