%----(1) Initialize the parameters, generate grid
%        for qj -----
a   = 20;
c   = 2;
b   = 1;
qj  = [0:20]';

%--- (2) Solve the best response for qi... ------
qi_star = NaN(size(qj));

for count = 1:size(qj, 1)
    qi_star(count, 1) = BestResponse(qj(count,...
                        1), c, a, b);
end

line(qj, qi_star, 'LineWidth', 2, 'Color',...
[1, 0, 0])
ylabel('q_i', 'FontSize',12)
xlabel('q_j', 'FontSize', 12)
