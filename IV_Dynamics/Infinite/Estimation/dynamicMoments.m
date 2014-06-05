function [Q] = dynamicMoments(ct,ctp,kt,ktp,params)
	% dynamicMoments(ct,ct+1,kt,kt+1,params) returns the
	% quadratic distance (scalar) based on dynamic model 
	% moments and specified values of alpha and theta
	alpha  =  params(1);
	theta  =  params(2);
	beta   =  0.9;
	k      =  size(params,2);

	%===============================================================
	% Form moments
	%===============================================================
	m1     = mean([ktp - theta*(kt - ct).^alpha]);
	m2     = mean([(ctp./(beta*ct))-alpha*theta*(kt-ct).^(alpha-1)]);

	%===============================================================
	% Create weight matrix and quadratic distance
	%===============================================================
	W      = eye(k);
	Q      = [m1 m2]*W*[m1 m2]';
return
