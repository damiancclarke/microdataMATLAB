function [TV optK] = IterateVF(V,maxK)
%------------------------------------------------
% PURPOSE: takes a potential value function V and
% performs an iteration, returning the updated
% proposed value function TV. When TV=V, we
% have found the true value function. The scalar
% maxK represents the maximum possible amount of
% capital that can be consumed in one period
%------------------------------------------------
% INPUTS: V   : Nx1 vector of potential value
%               function
%        maxK : scalar of maximum capital
%               that can be consumed in a period
%------------------------------------------------
% OUTPUT:TV   : updated value function
%        optK : vector of optimal capital amounts
%------------------------------------------------

%----- (1) Basic Parameters ---------------------
Alpha = 0.65; Beta = 0.9; Theta = 1.2;

grid  = length(V); 
K     = linspace(1e-6,maxK,grid)';
TV    = zeros(length(V),1);

%----- (2) Loop through and create new value
%----- function for each possible capital value
for k = 1:grid
    c = Theta*K(k)^Alpha-K(1:k);
    c(c<=0) = 0;
    u = log(c);
    [TV(k) optK(k)] = max(u + Beta*V(1:k));
end
return