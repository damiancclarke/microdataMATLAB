% A script to simulate different consumption decisions.

%************************************************************
%*** (1) setup, simulation of random variation
%************************************************************
clear

rng(1)

reps        = 100;

pshock      = [rand(reps, 1) * 50, zeros(reps, 1)];

I           = 10000;
P           = [100, 200];
x0          = [1, 1];
lb          = [0, 0];

c           = NaN(reps, 2);
opts        = optimset('algorithm', 'sqp', 'display', 'off');

%************************************************************
%*** (2) determine optimal consumption in each case
%************************************************************
for count = 1:reps

    TempP       = P + pshock(count, :);
    
    ub          = I./TempP;
    c(count, :) =   fmincon(@cobbdouglas,[1, 1], TempP, ...
                        I,[],[],lb,ub, [], opts);

end

%************************************************************
%*** (3) Visualise results
%************************************************************
subplot(1,2,1)
scatter(c(:, 1), c(:, 2))
axis([min(c(:,1))-5,max(c(:,1))+5, ...
      min(c(:,2))-5,min(c(:,2))+5]);
xlabel('Good 1 Consumption')
ylabel('Good 2 Consumption')

subplot(1,2,2)
cdfplot(c(:, 1))
xlabel('Good 1 Consumption')
ylabel('F(p_1)')

return
