% bootstrapOLS.m is a script which estimates standard errors by
% bootrstrapping a linear model.  This illustrates the speed-ups that can
% reasonably be achieved in parallel computations with some overhead
%
% If we wanted to compare to (for example) Stata:
%			 bootstrap, reps(10000): reg mpg price weight, noheader

clear
rng(1)

if matlabpool('size') == 0
   matlabpool(12)
end

%==============================================================================
% (1) Open regression data
%==============================================================================
DataIn  = dlmread('auto.csv');
X       = DataIn(:, 2:3);
X       = [X, ones(74, 1)];
y       = DataIn(:, 1);

[beta, se]  = regress(y, X);
[beta, se]

%==============================================================================
% (2) Bootstrap standard errors (100,000 draws)
%==============================================================================
reps        = 100000;
BootstrapBeta   = NaN(reps, 3);

tic
parfor count = 1:reps        
    MyIndex     = round(rand(74, 1) * 74 + 0.5);
    BootstrapX  = X(MyIndex, :);
    BootstrapY  = y(MyIndex, :);
    
    BootstrapBeta(count, :)     = [regress(BootstrapY, BootstrapX)]';
end
toc

[beta, se, mean(BootstrapBeta)', std(BootstrapBeta)']

