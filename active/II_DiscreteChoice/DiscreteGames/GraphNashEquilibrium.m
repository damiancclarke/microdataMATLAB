%---- (3) Generate a grid for qi...--------------
qi = [0:20]';

%--- (4) Solve the best response for qj...-------
qi_star = NaN(size(qj));
  for count = 1:size(qj, 1)
  qj_star(count, 1) = BestResponse(qi(count,...
                      1), c, a, b);
end
