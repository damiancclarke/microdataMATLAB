function choice = SimulateMNProbit(x, betavec, omega)

N           = size(x, 1);
K           = size(x, 2);
J           = size(betavec, 1)/K + 1;

beta        = reshape(betavec, K, J - 1);
xb          = x * beta;

diff            = [xb + mvnrnd(zeros(J - 1, 1), omega, N), zeros(N, 1)];
[junk, choice]  = max(diff, [], 2);

GraphSimulatedData(diff, choice)

return