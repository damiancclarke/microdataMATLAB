%----(1) Setup, simulation of random variation --
clear

% random variation in prices
P      = [50, 200];
reps   = 100;
pshock = [rand(reps, 1) * 50, zeros(reps, 1)];

I      = 10000; % income

%---(2) Determine optimal consumption in
%       each case ----
x0     = [1, 1];
lb     = [0, 0];

opts   = optimset('algorithm', 'sqp',...
                  'display', 'off');

c      = NaN(reps, 2);
for i = 1:reps
    TempP     = P + pshock(i, :);
    ub        = I./TempP;
    c(i, :) = fmincon(@CobbDouglas,[1, 1],TempP,...
                  I,[],[],lb,ub, [], opts);
end

%---(3) Visualize results -----------------------
subplot(1, 2, 1)
scatter(c(:,1), c(:,2))
xlabel('Good 1 Consumption')
ylabel('Good 2 Consumption')

subplot(1,2,2)
cdfplot(c(:, 1))
xlabel('Good 1 Consumption')
ylabel('F(p_1)')
