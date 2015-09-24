function qi    = BestResponse(qj, ci, a, b)
%------------------------------------------------
% PURPOSE: returns the best response for firm i to
%          output q_j.
%------------------------------------------------
% INPUTS:  qj : quantity produced by firm j
%          ci : MC for i
%          a : intercept
%          b : slope
%------------------------------------------------
% OUTPUT:  qi : best reponse for firm i
%------------------------------------------------

options = optimset('Algorithm', 'sqp',...
                                'Display', 'off');
qi  = fmincon(@(q) -Profit(q, qj, ci, a, b),...
          0, [], [], [], [], 0, [], [], options);

return
