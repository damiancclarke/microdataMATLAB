function beta = gpuExample(N,k,method)
% gpuExample(N,k) creates an N by k matrix of X variables, and an N by
% 1 matrix of y variables and calculates betas and standard errors using
% GPU computation.
rng(27) 
X = rand(N,k);
y = rand(N,1);
if method=='GPU'
    X = gpuArray(X);
    y = gpuArray(y);     
end
tic
beta = mldivide((X'*X),(X'*y));
toc
return
