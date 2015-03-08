%----- (1) Setup parameters, pre-fill matrices -------------------
cmap   = cool(7);
V      = zeros(1000,1);
K      = linspace(1e-6,100,1000);
aB     = 0.65*0.9; theta = 1.2; alpha = 0.65;

%----- (2) Plot analytical solution to determine performance -----
plot(K, aB*theta*K.^alpha, '-k','LineWidth',3)
hold all

%----- (3) Iterate using the Howard Algorithm, plot each step ----
for l=1:7
    [V,k]    = iteratePolicy(V,100); 
    plot(K,K(k), 'color', cmap(l,:))
end

legend('Analytical', 'Iter1', 'Iter 2', 'Iter 3', 'Iter 4', ...
       'Iter 5', 'Iter 6', 'Iter 7', 'Location', 'NorthWest')
xlabel('Amount of Capital', 'FontSize',12)
ylabel('Optimal k_{t+1}', 'FontSize',12)
title('Policy Function Iteration and Optimal Consumption', ...
'FontSize',16)
