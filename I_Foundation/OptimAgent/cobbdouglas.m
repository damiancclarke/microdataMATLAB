function [u] = cobbdouglas(X)
%Function to calculate utility given a Cobb-Douglas specification and
%varying the quantities of goods consumed

x1=X(1);
x2=X(2);

u=-(x1^0.5)*(x2^0.5);

end
