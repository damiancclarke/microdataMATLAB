function GraphSimulatedData(utility, y)

cla
scatter((utility(y == 1, 1) - utility(y == 1, 3)), (utility(y == 1, 2) - utility(y == 1, 3)))
hold on
scatter((utility(y == 2, 1) - utility(y == 2, 3)), (utility(y == 2, 2) - utility(y == 2, 3)))
hold on
scatter((utility(y == 3, 1) - utility(y == 3, 3)), (utility(y == 3, 2) - utility(y==3 , 3)))
hold on
plot([min((utility(:, 1) - utility(:, 3))), 0], [0, 0], 'LineWidth', 3, 'Color', [0, 0, 0])
hold on
plot([0, max(utility(:, 1) - utility(:, 3))], ...
            [0, max(utility(:, 1) - utility(:, 3))], 'LineWidth', 3, 'Color', [0, 0, 0])
hold on
plot([0, 0], [min(utility(:, 1) - utility(:, 3)), 0], 'LineWidth', 3, 'Color', [0, 0, 0])


return