function Sbeta = ghat_ni(X, y, param)

h=param(1) ;
beta=param(2:end) ;

n = length(y);

% quick function to make evaluation of normal easy
krnl = @(u) exp(-(u.*u)/2)/sqrt(2*pi);

% calculate the leave one out function given beta and h 
ghat_ = NaN(n,1);
for i = 1: n
    Xj = X(setdiff(1:n, i),:);
    yj = y(setdiff(1:n, i));
    Xi = repmat(X(i,:),n-1,1);  
    z = ((Xj - Xi)*beta)/h;
    Ku = krnl(z);
    ghat_(i) = sum(Ku.*yj)/sum(Ku);
end

% calculate the error
sq_error = (y - ghat_).^2;
Sbeta = sum(sq_error);

return