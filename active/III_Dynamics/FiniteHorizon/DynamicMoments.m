function Q=DynamicMoments(ct,ctp,kt,ktp,params)
%------------------------------------------------
% PURPOSE: returns the quadratic distance based
% on dynamic model moments and specified values
% of alpha and theta
%------------------------------------------------
% INPUTS:  ct     : Nx1 vector of C_t
%          ctp    : Nx1 vector of C_{t+1)
%          kt     : Nx1 vector of K_t
%          ktp    : Nx1 vector of K_(t+1)
%          params : Alpha, Theta
%------------------------------------------------
% OUTPUT:  Q      : value of moment conditions
%------------------------------------------------

Alpha = params(1);
Theta = params(2);
Beta  = 0.9;
k     = size(params,2);

%----- (1) Form moments -------------------------
m1   = mean([ktp - Theta*(kt - ct).^Alpha]);
m2   = mean([(ctp./(Beta*ct))-Alpha*Theta*...
             (kt-ct).^(Alpha-1)]);

%----- (2) Create weight matrix and quadratic
%          distance -------
W    = eye(k);
Q    = [m1 m2]*W*[m1 m2]';
return