%**********************************************************************
%*** (1) Plot analytical solution
%**********************************************************************
Beta = 0.9; alpha = 0.65; theta = 1.2; aB = alpha*Beta;

E = alpha/(1-aB);
F = 1/(1-Beta)*(log(theta*(1-aB)) + (aB*log(aB*theta))/(1-aB));

K = linspace(1e-6,100,1000);
soln = E*log(K)+F;

plot(K,soln, '-k', 'LineWidth', 3)
axis([0 100 -15 10])
hold on
%**********************************************************************
%*** (1) Plot 10 value function iterations
%**********************************************************************
TV = [zeros(1000,1) NaN(1000,66)];
for iter = 1:50
  fprintf('We are on iteration %d\n', iter)
	TV(:,iter+1)=iterateVF(TV(:,iter),100);
end

plot(K,TV)
xlabel('Amount of Capital', 'FontSize', 12)
ylabel('Value Function', 'FontSize', 12)
title('Value Function Iteration', 'FontSize', 14)