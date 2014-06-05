function LL = MNLogitLL(betavec, y, x)

N           = size(x, 1);
K           = size(x, 2);
J           = size(betavec, 1)/K + 1;

beta        = reshape(betavec, K, J - 1);

expxb               = exp(x * beta);
expxb_augmented     = [expxb, ones(N, 1)];

MyIndex             = NaN(N, J);

for count = 1:J
  MyIndex(:, count)     = (y == count);
end

ll_i    = log(sum(expxb_augmented .* MyIndex, 2) ./ sum(expxb_augmented, 2));

LL      = -sum(ll_i);

return