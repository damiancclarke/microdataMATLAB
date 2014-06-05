clear
%clc

%==========================================================================
%=== (1) Setup parameters
%==========================================================================
epsilon  =  [2 -2];
pi       =  [0.5 0.5];
Beta     =  0.9;
K1       =  100;
grid     =  0.2;
T        =  10;
theta    =  1.2;
alpha    =  0.98;

K        =  0:grid:K1+max(epsilon);
V        =  [NaN(length(K),T), zeros(length(K),1)];
aux      =  NaN(length(K),length(K),T);


%==========================================================================
%=== (2) Loop over possible values of c, k and epsilon
%==========================================================================
for t = 1:T
   p = T+1-t
   for inK = 1:length(K)
      for outK = 1:inK
         c = K(inK)-(K(outK)/theta)^(1/alpha);
         EVplus1  =  theta*(K(inK)-c)^alpha+epsilon*pi';
         position = round(EVplus1/grid + 1);
         aux(inK,outK,p)=log(c)+Beta*V(position,p+1);
      end
   end
   V(:,p)=max(aux(:,:,p),[],2);
end
