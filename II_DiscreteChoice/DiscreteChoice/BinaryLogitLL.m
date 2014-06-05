function [LL, ll_i] = BinaryLogitLL(beta, y, x)

Lambda_xb   = Lambda(x * beta);

ll_i        = y .* log(Lambda_xb) + (1 - y) .* log(1 - Lambda_xb);

LL          = -sum(ll_i);

return