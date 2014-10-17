function [d,deq] = flowConstraint(CK,T,K1,theta,alpha)
    % flowConstraint(C,k,T,K1, theta, alpha) sets up the system of 
    % constraints k_{t+1}=\theta(k_t-c_t)^\alpha.  It requires CK, a Tx2 
    % matrix of consumption and capital values in each of the T periods, 
    % K1, the stock of k at the beginning of the first period, and the 
    % production parameters alpha and theta.

    cap  =   CK(:,2);
    c    =   CK(:,1);
    k    =   [K1; cap];

    for t = 1:T
        deq(t)  =  k(t+1) - theta * (k(t)- c(t))^alpha ;
    end
  
    d    =  [];

return
