function S  = SimulateMNProbit_Smoothed(x, betavec, omega)

smoother    = .01;

N           = size(x, 1);
K           = size(x, 2);
J           = size(betavec, 1)/K + 1;

beta        = reshape(betavec, K, J - 1);
xb          = x * beta;

diff        = [xb + mvnrnd(zeros(J - 1, 1), omega, N), zeros(N, 1)];

expdiff     = exp(diff/smoother);

for count = 1:J
    S(:, count)     = expdiff(:, count) ./ sum(expdiff, 2);
end

return