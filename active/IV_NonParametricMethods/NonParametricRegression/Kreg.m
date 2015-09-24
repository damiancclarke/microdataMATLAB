function [yhat,h] = Kreg(X,y,x,h0,func)
%------------------------------------------------
% PURPOSE: performs the kernel regression of y on
%          (univar) X
%------------------------------------------------
% USAGE: yhat = Kreg(X,y,x,h0,func)
% where: y    : n-by-1 dependent variable
%        X    : n-by-1 independent variable
%        x    : N-by-1 points of evaluation
%        h0   : scalar bandwidth
%        func : kernel function
%------------------------------------------------
% OUTPUT:    h : bandwidth used
%         yhat : regression evaluated at each
%                element of x
%------------------------------------------------
n = length(y);
N = length(x);

%--- (1) Set bandwidth if not supplied ----------
if nargin < 4
    % suggested by Bowman and Azzalini (1997)
    hx=median(abs(X-median(X)))/0.6745*(4/3/n)^0.2;
    hy=median(abs(y-median(y)))/0.6745*(4/3/n)^0.2;
    h=sqrt(hy*hx);
else
    h = h0;
end

%--- (2) Set Kernel function if so desired ------
if nargin < 5
    % Gaussian as default
    krnl = @(u) exp(-(u.*u)/2)/sqrt(2*pi);
else
    K = {'Gaussian', 'Uniform', 'Epanechnikov'};

    if strcmpi(func, K{1})
        % Gaussian
        krnl = @(u) exp(-(u.*u)/2)/sqrt(2*pi);
    elseif strcmpi(func, K{2})
        % Uniform
        krnl = @(u) 0.75*(1 - (u.*u)).*(abs(u) <= 1);
    elseif strcmpi(func, K{3})
        % Epanechnikov
        krnl = @(u) 0.5.*(abs(u) <= 1);
    else
        % --> if there's been a mistake- Gaussian
        krnl = @(u) exp(-(u.*u)/2)/sqrt(2*pi);
    end
end

%--- (3) Perform kernel regression! -------------
yhat = NaN(N,1);
for i = 1:N
    u = (X - x(i))/h;
    Ku = krnl(u);
    yhat(i) = sum(Ku.*y)/sum(Ku);
end

return