function[ratio1, ratio2, ratio3] = TimeTests(n)
% timetests(n) runs tests for vectors of length n.  This tests how a
% naive loop compares to vectorised code, and how this compares to
% using a loop over a preallocated array.


    %****************************************************************
    %*** (1) Generate n x 1 vector of ones in four different ways
    %****************************************************************    
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

    %****************************************************************
    %*** (2) Calculate ratio of slow methods to fast method
    %****************************************************************        
    ratio1 = rowloop/vect;
    ratio2 = loop/vect;
    ratio3 = prealloc/vect;
return