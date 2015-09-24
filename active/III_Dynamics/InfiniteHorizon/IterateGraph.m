%-----(1) Set parameters, plot analytical
%         solution -----
Beta = 0.9; Alpha = 0.65; Theta = 1.2;
aB = Alpha*Beta;
K = linspace(1e-6,100,1000);

E = Alpha/(1-aB);
F = 1/(1-Beta)*(log(Theta*(1-aB))...
                + aB*log(aB*Theta)/(1-aB));
soln = E*log(K)+F;

plot(K,soln, '-k', 'LineWidth', 3)
axis([0 100 -15 10])
hold on

%----- (2) Plot 10 value function iterations ----
TV = [zeros(1000,1) NaN(1000,9)];
for iter = 1:10
    fprintf('Iteration number %d\n', iter)
    TV(:,iter+1)=IterateVF(TV(:,iter),100);
end

plot(K,TV)
xlabel('Amount of Capital', 'FontSize', 12)
ylabel('Value Function', 'FontSize', 12)
title('Value Function Iteration', 'FontSize', 14)
