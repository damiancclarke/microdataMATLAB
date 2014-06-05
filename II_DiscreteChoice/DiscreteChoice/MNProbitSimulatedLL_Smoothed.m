function LL = MNProbitSimulatedLL_Smoothed(parameters, y, x, R)

betavec         = parameters(1:end-1);
rho             = parameters(end);

omega           = [1, rho; rho, 1];

rng(1);

N               = size(y, 1);
J               = max(y);

SimulatedS      = NaN(N, J, R);
SimulatedProb   = NaN(N, J);

for count = 1:R
    SimulatedS(:, :, count)     = SimulateMNProbit_Smoothed(x, betavec, omega);
end

SimulatedProb   = mean(SimulatedS, 3);

for count = 1:J
    MyIndex(:, count)           = (y == count);
end

ll_i            = sum(MyIndex .* log(SimulatedProb), 2);
LL              = -sum(ll_i);

return