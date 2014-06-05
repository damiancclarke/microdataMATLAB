function [beta,opth] = ichimura(X,y)
%--------------------------------------------------------------------------
% PURPOSE: performs a single index regression using Ichimura's estimator
% imposing beta(1) = 1 as the normalisation condition
%--------------------------------------------------------------------------
% USAGE: [beta,yhat] = ichimura(X,y)
% where: y = n-by-1 dependent variable
%        X = n-by-K independent variable
%--------------------------------------------------------------------------
% OUTPUT: beta = coefficients on index
%         opth = bandwidth 
%--------------------------------------------------------------------------
n = length(y);

% starting value for beta (OLS)
y_ = y - X(:,1);
X_ = X(:,2:end);

beta0 = (X_'*X_)\X_'*y_;
beta0 = [1; beta0];

% starting values for the h's (Bowman and Azzalini (1997))
x_ = X*beta0;
hx=median(abs(x_-median(x_)))/0.6745*(4/3/n)^0.2;
hy=median(abs(y-median(y)))/0.6745*(4/3/n)^0.2;
h=sqrt(hy*hx);   

% gubbins
param0 = [h;beta0];
options = optimset('Display', 'off', 'Algorithm', 'sqp',...
    'MaxFunEvals', 1e5, 'MaxIter', 1e5,'TolX',1e-10,'TolFun',1e-10);
Aeq = zeros(1, length(param0));
Aeq(2) = 1;
beq = 1;
lb = [0;-Inf(length(beta0),1)];

% determine optimal h and beta by minimising squared error
Param = fmincon(@(p) ghat_ni(X, y, p), param0, [],[],...
    Aeq,beq,lb, [], [] ,options);

opth = Param(1);
beta = Param(2:end);

return

