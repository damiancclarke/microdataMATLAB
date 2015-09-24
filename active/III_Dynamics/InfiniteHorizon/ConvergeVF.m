%----- Convergence to the Value Function --------
conv = 100;
crit = 1e-2;

K    = linspace(1e-6,100,1000);
V    = zeros(1000,1);
axis([0 100 -15 10])
hold on

cc   = hot(70);
Iter = 0;

while conv>crit
    Iter      = Iter+1
    [TV optK] = IterateVF(V,100);
    conv      = max(abs(TV-V))
    plot(K,TV, 'color', cc(Iter,:))
    V         = TV;
end