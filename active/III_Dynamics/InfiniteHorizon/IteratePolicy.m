function [V,opt] = IteratePolicy(V, maxK)
%------------------------------------------------
% PURPOSE: takes an aribitrary value function
% V and iterates over the policy function c(k).
% At each step it calculates an updated policy
% function c_j(k), and a corresponding value
% function V_j(k), which is the value of.
% following c_j(k) forever.
%------------------------------------------------
% INPUTS:  V   : Nx1 vector of potential value
%                function
%         maxK : scalar of maximum capital
%                that can be consumed in a period
%------------------------------------------------
% OUTPUT: V   : updated value function at each
%               point
%         opt : optimal k for V
%------------------------------------------------

%----- (1) Parameters ---------------------------
Alpha = 0.65; Beta = 0.9; Theta = 1.2;
grid  = length(V);
K     = linspace(1e-6,maxK,grid)';
opt   = NaN(grid,1);

%----- (2) Calculate optimal k for V ------------
for k = 1:grid
    c           = Theta*K(k)^Alpha-K(1:k);
    c(c<=0)     = 0;
    u           = log(c);
    [V1,opt(k)] = max(u+Beta*V(1:k));
end

kopt = K(opt);
c    = Theta*K.^Alpha-kopt;
u    = log(c);

%----- (3) Invert k, u to find V_{j+1} ----------
Q  = sparse(grid,grid);

for k = 1:grid
    Q(k,opt(k)) = 1;
end
TV =  (speye(grid)-Beta*Q)\u;
V  =  TV;
return

