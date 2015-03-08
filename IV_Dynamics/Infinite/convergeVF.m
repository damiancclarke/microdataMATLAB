%======================================================================
% Convergence to the value function
%======================================================================
conv = 100;
crit = 1e-2;

K = linspace(1e-6,100,1000);
V = zeros(1000,1);
axis([0 100 -18 10])
hold on

cc=hot(70);
Iter = 0;

while conv>crit
	Iter = Iter+1
	[TV optK] = iterateVF(V,100);
	conv = max(abs(TV-V))
	plot(K,TV, 'color', cc(Iter,:))
	V = TV;
end

xlabel('Amount of Capital', 'FontSize', 12)
ylabel('Value Function', 'FontSize', 12)
%title('Value Function Iteration', 'FontSize', 14)

