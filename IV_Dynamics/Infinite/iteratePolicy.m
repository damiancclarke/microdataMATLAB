function [V,opt] = iteratePolicy(V, maxK)
	% iteratePolicy(V, maxK) takes an aribitrary value
	% function V and iterates over the policy function.
	% c(k). In this case we simply ensure that capital
	% is optimally used for our arbitrarily defined V.
	%
	% The scalar maxK defines the maximum possible 
	% capital that can be consumed in one period.
	%
	% see also iterateVF

	%==================================================
	%=== (1) Parameters
	%==================================================
	alpha  =  0.65; beta  =  0.9;  theta  =  1.2;
	grid   =  length(V);
	K      =  linspace(1e-6,maxK,grid)';
	opt    =  NaN(grid,1);

	%==================================================
	%=== (2) Calculate optimal k for V
	%==================================================
	for k  =  1:grid
		c               =  theta*K(k)^alpha-K(1:k);
		c(c<=0)         =  0;
		u               =  log(c);
		[V1,opt(k)]     =  max(u+beta*V(1:k));
	end
   
	kopt =  K(opt);
	c    =  theta*K.^alpha-kopt;
	u    =  log(c);

	%==================================================
	%=== (3) Invert k, u to find V_{j+1}
	%==================================================
	Q    =  sparse(grid,grid);

	for  k  =  1:grid
		Q(k,opt(k)) = 1;
	end
	TV  =  (speye(grid)-beta*Q)\u;
	V   =  TV;
return
