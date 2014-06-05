function V = flowUtility(T,Beta,C)
    % flowUtility(T,Beta,C) takes T periods of consumption of size C and 
    % calculates the total utility of consumption assuming an additively 
    % separable utility function, an discount rate Beta.
    %
    % The utility function at each individual point in time is 
    % assumed to be u(c_t)=ln(c_t).

    c   =   C(:,1);

    t   =   [1:1:T];
    V   =   Beta.^(t-1)*log(c);
    V   =   -V;

return
