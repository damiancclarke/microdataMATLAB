function [TV, opt]  =  iterateVF(V, maxK)
  % iterateVF(V, maxK) takes a potential value function V and 
  % performs an iteration, returning the updated proposed value 
  % function TV.  When TV==V, we have found the true value 
  % function.  The scalar maxK represents the maximum possible
  % amount of capital that can be consumed in one period.

  %============================================================
  %=== (1) Basic parameters
  %============================================================
  alpha   =  0.65;
  beta    =  0.9;
  theta   =  1.2;

  grid    =  length(V);
  K       =  linspace(1e-6,maxK,grid)';
  TV      =  zeros(length(V),1);
	%============================================================
  %=== (2) Loop through and create new value function for each
  %===     possible capital value 
	%============================================================
  for k = 1:grid
    c               =  theta*K(k)^alpha-K(1:k);
    c(c<=0)         =  0;
    u               =  log(c);
    [TV(k),opt(k)]  =  max(u+beta*V(1:k)); 
  end
return
