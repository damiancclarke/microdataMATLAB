function u = UtilitySimple(x1, x2)
%------------------------------------------------
% PURPOSE: calculate utility: 2 good Cobb-Douglas
%          specification
%------------------------------------------------
% USAGE: u : UtilitySimple(x1, x2)
% where: x1 : quantity of q1
%        x2 : quantity of q2
%------------------------------------------------
% OUTPUT: u : overall utility
%------------------------------------------------

u  =  (x1^0.5) * (x2^0.5);

return
