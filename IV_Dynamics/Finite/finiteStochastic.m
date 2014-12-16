clear; 

%**************************************************************************
%*** (1) Setup parameters
%**************************************************************************
epsilon  =  [-2 2];
PI       =  [0.5 0.5];
Beta     =  0.9;
K1       =  100;
grid     =  0.1;
T        =  10;
theta    =  1.2;
alpha    =  0.98;

K        =  0:grid:K1+max(epsilon);
V        =  [NaN(length(K),T), zeros(length(K),1)];
aux      =   NaN(length(K),length(K),T);


%**************************************************************************
%*** (2) Loop over possible values of c, k and epsilon
%**************************************************************************
for t = T:-1:1
	fprintf('Currently in period %d\n', t)

	for inK = 1:length(0:grid:K1)
		for outK = 1:inK
			c                =  K(inK) - K(outK);
      nextKl           =  K(inK) - c + epsilon(1);
      nextKh           =  K(inK) - c + epsilon(2);
      if nextKl<0
  			nextKl=0;
      end

      EnextV           =  PI(1) * V((round(nextKl/grid)+1), t+1) + ...
                          PI(2) * V((round(nextKh/grid)+1), t+1);
      aux(inK,outK,t)  =  log(c) + Beta*EnextV;
		end
	end
	V(:,t)=max(aux(:,:,t),[],2);
end
