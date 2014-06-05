function opth = cross_val_h(x,y,h0)
%--------------------------------------------------------------------------
% PURPOSE: cross_val_h returns the optimal glbal bandwidth for the kernel
%           regression of y on X determined by cross-validation 
%--------------------------------------------------------------------------
% USAGE: opth = cross_val_h(x,y,h0)
% where: y = n-by-1 dependent variable
%        x = n-by-k independent variable
%        h0 = scalar strating value
%--------------------------------------------------------------------------
options = optimset('Display', 'off', 'Algorithm', 'sqp');
opth = fmincon(@(h)MSE(x,y,h), h0, [],[], [],[], 0, 10,[], options);

