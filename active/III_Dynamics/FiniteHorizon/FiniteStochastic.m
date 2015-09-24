%clear; clc;

%----- (1) Setup parameters ---------------------
e     = [-2 2];
PI    = [0.5 0.5];
Beta  = 0.9; Theta = 1.2; Alpha = 0.98;
K1    = 100;
grid  = 0.1;
T     = 10;

K     = 0:grid:K1+max(e);
V     = [NaN(length(K),T), zeros(length(K),1)];
aux   = NaN(length(K),length(K),T);

%----- (2) Loop over possible values of c, k and
%          epsilon -----
for t = T:-1:1
    fprintf('Currently in period %d\n', t)
    for inK = 1:length(0:grid:K1)
        for outK = 1:inK
            c = K(inK) - (K(outK)/Theta)^(1/Alpha);
            nextKl = Theta*(K(inK) - c)^Alpha + e(1);
            nextKh = Theta*(K(inK) - c)^Alpha + e(2);
            nextKl(nextKl<0) = 0;

            EnextV = PI(1) * V((round(nextKl/grid)+1),...
              t+1) + PI(2) * V((round(nextKh/grid)+1),t+1);
            aux(inK,outK,t) = log(c) + Beta*EnextV;
        end
    end
    V(:,t)=max(aux(:,:,t),[],2);
end