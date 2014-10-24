function J = objective(beta,y,X)
% J = objective(beta,y,X) calculates the moments of a linear
% model given input data y (a vector), X (a matrix including
% an intercept of all ones if desired), and the point estimates
% beta.  The true method of moments estimate of beta occurs
% when J=0.
%
% The series of moments that are being fitted here are:
% [E(X_1u)=0  E(X_2*u)=0 ... E(X_k*u)=0]


%*****************************************************************
% *** (1) determine sample size N and number of coefficients k
%*****************************************************************
N = length(y);
k = size(X,2);

%*****************************************************************
% *** (2) Calculate u and generate the (arbitrary) weight matrix
%*****************************************************************
u = y - X*beta;
W = eye(k);

%*****************************************************************
% *** (3) Generate moment vector (1*3) in this case
%*****************************************************************
m = 1/N*u'*[X(:,1) X(:,2) X(:,3)];
J = m*W*m';


return