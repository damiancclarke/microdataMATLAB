function [LL, ll_i] = BinaryLogitSimulatedLL(beta, y, x, R)

rng(1);

N               = size(y, 1);
Simulated_y     = NaN(N, R);

for count = 1:R
    Simulated_y(:, count)   = SimulateBinaryLogit(x, beta);
end

SimulatedProb   = mean(Simulated_y, 2);

ll_i            = y .* log(SimulatedProb) + (1 - y) .* log(1 - SimulatedProb );
LL              = -sum(ll_i);

return