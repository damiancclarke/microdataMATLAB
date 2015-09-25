clear
rng(1)

if matlabpool('size') == 0
    matlabpool(4)
end

%--(1) Open regression data --------------------
DataIn = dlmread('auto.csv');
X = DataIn(:, 2:3);
X = [X, ones(74, 1)];
y = DataIn(:, 1);
N = size(X, 1);

[Beta, se] = regress(y, X);
[Beta, se]

%--(2) Bootstrap standard errors (100,000
%      draws) ----
reps          = 100000;
BootstrapBeta = NaN(reps, 3);

tic
parfor count = 1:reps
    MyIndex  = randi(N, N, 1);
    BootX    = X(MyIndex, :);
    BootY    = y(MyIndex, :);

    BootstrapBeta(count, :) = [regress(BootY,...
                                       BootX)]';
end
toc

[Beta, se, mean(BootstrapBeta)',...
 std(BootstrapBeta)']