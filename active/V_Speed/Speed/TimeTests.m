function[ratio1, ratio2, ratio3] = TimeTests(n)
%------------------------------------------------
% PURPOSE: Test performance of loops vs
%          vectorized code
%------------------------------------------------
% INPUTS: n : The size of the vector that should
%             be filled
%------------------------------------------------
% OUTPUT: ratio1 : ratio of using a row loop vs
%                  vectorizing
%         ratio2 : ratio of using a column loop
%                  vs vectorizing
%         ratio3 : ratio of a preallocated loop
%                  vs vectorizing
%------------------------------------------------

%----- (1) Generate n x 1 vector of ones in 4
%          different ways --
tic; vectones = ones(n,1); vect=toc;

tic; for i=1:n
    rowloopones(1,i) = 1;
end; rowloop=toc;

tic; for i=1:n
    loopones(i) = 1;
end; loop=toc;

preloop = NaN(n,1);
tic; for i=1:n
    preloop(i) = 1;
end; prealloc = toc;

%----- (2) Calculate ratio of slow methods to
%          fast method -----
ratio1 = rowloop/vect;
ratio2 = loop/vect;
ratio3 = prealloc/vect;
return