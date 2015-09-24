function value = MSE(X,y,h)
%------------------------------------------------
% PURPOSE: calculate the MSE for the leave-one-
%          out kernel reg
%------------------------------------------------
% INPUTS: X : Nx1 vector of independent variable
%         y : Nx1 vector of dependent variable
%         h : candidate bandwidth
%------------------------------------------------
% OUTPUT: value : mean squared error of
%                 leave-one-out
%------------------------------------------------

%----- (1) Declare kernel function --------------
krnl = @(u) exp(-(u.*u)/2)/sqrt(2*pi);

%----- (2) Summary vectors ----------------------
N          = length(X);
yhat       = NaN(N,1);
weight_i   = NaN(N,1);
weight_sum = NaN(N,1);

%-----(3) Perform kernel regression & save
%         weights ------
for i = 1:N
    u = (X - X(i))/h;
    Ku = krnl(u);
    weight_i(i) = Ku(i);
    weight_sum(i) = sum(Ku);
    yhat(i) = sum(Ku.*y)/sum(Ku);
end

%----- (4) Calculate leave-1-out MSE ------------
residual = (y-yhat)./(1-(weight_i./weight_sum));
value = sum(residual.^2);

return