function V = FlowUtility(T,Beta,C)
%------------------------------------------------
% PURPOSE: calculates the total utility of
% consumption assuming an additively separable
% utility function and discount rate Beta.
%------------------------------------------------
% INPUTS: C : Tx1 vector of independent variable
%         T : scalar time
%         Beta : scalar discount rate
%------------------------------------------------
% OUTPUT: V : -utility
%------------------------------------------------

c = C(:,1);

t = [1:1:T];
V = Beta.^(t-1)*log(c);
V = -V;

return