function [yhat,h] = kreg(X,y,x,h0,func)
%--------------------------------------------------------------------------
% PURPOSE: performs the Gaussian regression of y on (univariate) X
%--------------------------------------------------------------------------
% USAGE: yhat = kreg(X,y,x,h0)
% where: y = n-by-1 dependent variable
%        X = n-by-1 independent variable
%        x = N-by-1 points of evaluation   
%        h0 = scalar bandwidth
%--------------------------------------------------------------------------
% OUTPUT: yhat.h = bandwidth used
%         yhat.f = regression function evaluated at each elemnt of x  
%--------------------------------------------------------------------------
n = length(y);
N = length(x);

%% Determine bandwidth if not supplied (just use the plug-in version)
if nargin < 4
    % suggested by Bowman and Azzalini (1997)
    hx=median(abs(x-median(x)))/0.6745*(4/3/n)^0.2;
    hy=median(abs(y-median(y)))/0.6745*(4/3/n)^0.2;
    h=sqrt(hy*hx);    
else
    h = h0;
end

%% Determine Kernel function if so desired 
if nargin < 5
    % Gaussian as default
    krnl = @(u) exp(-(u.*u)/2)/sqrt(2*pi);
else
    K = ['Gaussian    '; 'Epanechnikov'; 'Uniform     '];
    K = cellstr(K);
    if strcmp(func,K(1))==1
        krnl = @(u) exp(-(u.*u)/2)/sqrt(2*pi);
    elseif strcmp(func,K(2))==1
        krnl = @(u) 0.75*(1 - (u.*u)).*(abs(u) <= 1);
    elseif strcmp(func,K(3))==1
        krnl = @(u) 0.5.*(abs(u) <= 1);
    else
        krnl = @(u) exp(-(u.*u)/2)/sqrt(2*pi);
    end
end

%% Perform kernel regression!
yhat = NaN(N,1);
for i = 1:N
    u = (X - x(i))/h;
    Ku = krnl(u);
    yhat(i) = sum(Ku.*y)/sum(Ku);
end

return
