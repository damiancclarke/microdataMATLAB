function u = CobbDouglas(X)
%------------------------------------------------
% PURPOSE: calculate utility: 2 good Cobb-Douglas
%          specification
%------------------------------------------------
% USAGE: u : CobbDouglas(X)
% where: X : 2-by-1 quantity vector
%------------------------------------------------
% OUTPUT: u : overall utility
%------------------------------------------------

x1 =  X(1);
x2 =  X(2);
u  =  -(x1^0.5)*(x2^0.5);

return


