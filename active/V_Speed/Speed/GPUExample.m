function Betas = GPUExample(N,k,method)
%------------------------------------------------
% PURPOSE: Creates and inverts matrices using GPU
%          computing
%------------------------------------------------
% INPUTS:      N: The number of rows in the X
%                 and y matrices
%              k: The number of columns in the
%                 X matrix
%         method: calculation method. Must be
%                 'GPU' or 'CPU'
%------------------------------------------------
% OUTPUT: Betas : result of inv(X'X)*(X'y)
%------------------------------------------------

if method=='GPU'
    X = gpuArray(rand(N,k));
    y = gpuArray(rand(N,1));
elseif method=='CPU'
    X = rand(N,k);
    y = rand(N,1);
end
tic
Betas = mldivide((X'*X),(X'*y));
toc
return