%----- (1) Basic illustration of parfor ---------
matlabpool open
tic
parfor count = 1:12
    count
    pause(1)
end
toc

%----- (2) consider a problem that is not
%          parallelizable -----
fibonacci    = zeros(15, 1);
fibonacci(1) = 1;
fibonacci(2) = 1;

for c = 3:size(fibonacci, 1)
    c
    fibonacci(c) = fibonacci(c - 1) + ...
                   fibonacci(c - 2);
end

%--- (3) this IS parallelizable, but needs
%        careful construction -----
%MyObviousMatrix   = NaN(10, 2);
MyObviousMatrix1 = NaN(10, 1);
MyObviousMatrix2 = NaN(10, 1);

parfor count = 1:10
    count
    %MyObviousMatrix(count, 1) = 1;
    %MyObviousMatrix(count, 2) = 2;
    
    MyObviousMatrix1(count) = 1;
    MyObviousMatrix2(count) = 2;
end
MyObviousMatrix = [MyObviousMatrix1,
MyObviousMatrix2];

return