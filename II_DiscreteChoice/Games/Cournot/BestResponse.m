function qi     = BestResponse(qj, ci, a, b)

% This function returns the best response for firm i to output q_j.

options     = optimset('Algorithm', 'sqp', 'Display', 'off');
qi          = fmincon(@(q) -Profit(q, qj, ci, a, b), 0, [], [], [], [], 0, [], [], options);

return