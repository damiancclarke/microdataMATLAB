% RunCournot

clear
cla

% Initialise the parameters...

a   = 20;
c   = 1;
b   = 1;

% Generate a grid for qj...

qj  = [0:20]';

% Solve the best response for qi...

qi_star     = NaN(size(qj));

for count = 1:size(qj, 1)
    qi_star(count, 1)   = BestResponse(qj(count, 1), c, a, b);
end

line(qj, qi_star, 'LineWidth', 2, 'Color', [1, 0, 0])

% Generate a grid for qi...

qi  = [0:20]';

% Solve the best response for qj...

qi_star     = NaN(size(qj));

for count = 1:size(qj, 1)
    qj_star(count, 1)   = BestResponse(qi(count, 1), c, a, b);
end

hold on
line(qj_star, qi, 'LineWidth', 2, 'Color', [0, 0, 1])

% Graph the loss function for the Cournot...

[q1, q2]            = meshgrid(4:0.25:10, 4:0.25:10);

CournotLossValue     = NaN(size(q1));

for count1 = 1:size(q1, 1)
    for count2 = 1:size(q1, 2)
        CournotLossValue(count1, count2)    = CournotLoss([q1(count1, count2), q2(count1, count2)], ...
                                                a, b, c, c);
    end
end

hold on 
surf(q1, q2, CournotLossValue)

% Solve for the Nash...

Nash = SolveNash(a, b, c, c)

hold on
scatter(Nash(1), Nash(2), 100, [0, 0, 0], 'filled')


return