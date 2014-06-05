function value = MSE(X,y,h)
%--------------------------------------------------------------------------
% PURPOSE: calaculate the MSE for the kernel reg of y on X given h
%--------------------------------------------------------------------------
N= length(X);
yhat = NaN(N,1);

%% Calculate the cross validation criterion function 
for i = 1:N
    % remove ith observation
    x0 = X(setdiff(1:N,i),:);
    y0 = y(setdiff(1:N,i),:);
    
    % caluclate yhat using kernel reg
    yhat(i) = kreg(x0,y0,X(i),h);
    
end
value = sum((y-yhat).^2);

