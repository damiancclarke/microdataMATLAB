function y = SimulateMNProbit(x, Betavec, Omega)

%------------------------------------------------
% PURPOSE: simulates the multinomial probit.
%------------------------------------------------
% INPUTS: x : NxK vector of independent variable
%         Betavec : Kx1 parameter vector
%         Omega : covariance matrix
%------------------------------------------------
% OUTPUT: choice : multinomial choice
%------------------------------------------------

%----- (1) Setup initial vectors ----------------
N          = size(x, 1);
K          = size(x, 2);
J          = size(Betavec, 1)/K + 1;

%----- (2) Calculate relative utility -----------
Beta =   reshape(Betavec, K, J - 1);
xb   =   x * Beta;
diff =  [zeros(N, 1), xb +...
         mvnrnd(zeros(J - 1, 1), Omega, N)];

%----- (3) Based on relative utility, determine
%          choice from J -
[~, y] = max(diff, [], 2);

return


