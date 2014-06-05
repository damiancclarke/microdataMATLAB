clear; 
%clc

%**************************************************************************
%*** (1) Setup parameters
%**************************************************************************
epsilon  =  [2 -2];
PI       =  [0.5 0.5];
Beta     =  0.9;
K1       =  100;
grid     =  0.1;
T        =  10;
theta    =  1.2;
alpha    =  0.98;

K        =  0:grid:K1+max(epsilon);
V        =  [NaN(length(K),T), zeros(length(K),1)];
aux      =  NaN(length(K),length(K),T);


%**************************************************************************
%*** (2) Loop over possible values of c, k and epsilon
%**************************************************************************
for t = T:-1:1
	fprintf('Currently in period %d\n', t)
	for inK = 1:length(K)
		for outK = 1:inK
			c               =  K(inK) - K(outK);
			EnextK          =  K(inK) - c + epsilon*PI';
			position        =  round(EnextK/grid + 1);
			aux(inK,outK,t) =  log(c) + Beta*V(position,t+1);
		end
	end
	V(:,t)=max(aux(:,:,t),[],2);
end
