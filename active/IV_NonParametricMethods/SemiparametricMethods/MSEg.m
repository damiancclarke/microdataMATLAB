function Sbeta = MSEg(X, y, param)
%-----------------------------------------------
% PURPOSE: implements Ichimura's SIM estimator
% imposing beta(1) = 1 as the normalization
% condition
%-----------------------------------------------
% INPUTS:     y : n-by-1 dependent variable
%             X : n-by-K independent variable
%         param : (1+K)-by-1 vector of
%                parameters (bandwidth and beta)
%-----------------------------------------------
% OUTPUT: Sbeta : MSE of leave one out estimator
%-----------------------------------------------
h=param(1) ;
beta=param(2:end) ;
N = length(y);
Xbeta = X*beta;

%----- (1) Declare kernel ----------------------
krnl = @(u) exp(-(u.*u)/2)/sqrt(2*pi);

%----- (2) Declare summary vectors -------------
yhat = NaN(N,1);
weight_i = NaN(N,1);
weight_sum = NaN(N,1);

%----- (3) NW regression & save weights --------
for i = 1:N
    u = (Xbeta - Xbeta(i))/h;
    Ku = krnl(u);
    weight_i(i) = Ku(i);
    weight_sum(i) = sum(Ku);
    yhat(i) = sum(Ku.*y)/sum(Ku);
end

%----- (4) Calculate leave-1-out MSE -----------
residual=(y - yhat)./(1-(weight_i./weight_sum));
Sbeta = sum(residual.^2);

return