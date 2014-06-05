function LL     = BayesianNashLL(parameters, Y, X)

mu_1        = parameters(1);
mu_2        = parameters(2);
delta_1     = parameters(3);
delta_2     = parameters(4);
rho         = parameters(5);

N           = size(X, 1);
ll          = NaN(N, 1);

[UniqueData, m, n]  = unique(X, 'rows');

cutoffs_small       = NaN(size(UniqueData, 1), 2);
for count = 1:size(UniqueData, 1)
    cutoffs_small(count, :)     = SolveBayesianNash(mu_1, mu_2, ...
                                    delta_1 * UniqueData(count, 1), delta_2 * UniqueData(count, 2), rho);
end

cutoffs_large       = cutoffs_small(n, :);

for count = 1:N
    q1                  = 2 * Y(count, 1) - 1;
    q2                  = 2 * Y(count, 2) - 1;

    ll(count)           = log(bvnl( q1 * (mu_1 - cutoffs_large(count, 1)), ...
                                    q2 * (mu_2 - cutoffs_large(count, 2)), q1 * q2 * rho));
    
end

LL  = -sum(ll);

return
