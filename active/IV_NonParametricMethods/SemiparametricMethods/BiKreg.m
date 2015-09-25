function [yhat,h,w,z] = BiKreg(X,y,x,h0)
%-----------------------------------------------
% PURPOSE: performs the kernel regression of y
%          on (bivar) X
%-----------------------------------------------
% USAGE: [yhat,h,w,z] = BiKreg(X,y,x,h0)
% where:  y : N-by-1 dependent variable
%         X : N-by-2 independent variable
%         x : n-by-2 points of evaluation
%        h0 : 2-by-1 bandwidth
%-----------------------------------------------
% OUTPUT:    h : bandwidths used
%         yhat : regression evaluated at the
%                n-by-n grid from columns of x
%-----------------------------------------------

%--- (1) Create grid of points ------------------
N = length(y);
n = size(x, 1);
[w,z] = meshgrid(x(:,1), x(:,2));


%--- (2) Set bandwidth if not supplied & kernel--
if nargin < 4
    hx = median(abs(X-repmat(median(X),...
                N,1)))/0.6745*(4/3/N)^0.2;
    hy = median(abs(y-repmat(median(y),...
                N,1)))/0.6745*(4/3/N)^0.2;
    h = sqrt(hy.*hx);
else
    h = h0;
end
hw = h(1);
hz = h(2);
krnl = @(u) exp(-(u.*u)/2)/sqrt(2*pi);


%--- (3) Perform bivariate kernel regression!---
%        Product kernel X(:,1)
KW = NaN(length(y),size(w,1));
W = X(:,1);
for w_ = 1 : size(w,1)
    wi = w(1,w_);
    uw = (W - wi)/hw;
    Kuw = krnl(uw);
    KW(:,w_) = Kuw;
end

% Product kernel X(:,2)
KZ = NaN(length(y),size(z,1));
Z = X(:,2);
for z_ = 1 : size(z,1)
    zi = z(z_, 1);
    uz = (Z - zi)/hz;
    Kuz = krnl(uz);
    KZ(:,z_) = Kuz;
end

% NW estimator
yhat = NaN(size(w,1), size(w,2));
for i = 1 : n
    for j = 1 : n
        Ku = KW(:,i).*KZ(:,j);
        yhat(j,i) = sum(Ku.*y)/sum(Ku);
    end
end

return