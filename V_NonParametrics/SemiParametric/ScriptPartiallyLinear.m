% Class Script: Linear Index Regression 

%% Faking some data 
%..... for example
Z = [1:100]';
X = 100*rand(length(Z),2);
beta = [2;3]; % make up a beta
y = sin(0.1*Z) + X*beta + randn(length(X),1);


%% Concentrate out X1
% 1. NP regression of y on Z
ghat_y = kreg(Z,y,Z);
ehat_y = y - ghat_y;

% 2. NP regression of X's on Z
ehat_X = NaN(size(X,1),size(X,2));
for i = 1:size(X,2)
    ghat_X = kreg(Z,X(:,i),Z);
    ehat_X(:,i) = X(:,i) - ghat_X;
end

%% Estimate for beta
bhat = (ehat_X'*ehat_X)\(ehat_X'*ehat_y);
