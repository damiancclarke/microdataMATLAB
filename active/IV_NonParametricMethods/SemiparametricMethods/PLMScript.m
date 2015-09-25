%----- (1) Simulate data -----------------------
X1 = 1 + 2*randn(1000,1);
X2 = 1 + 0.5*randn(1000,1);
X = [X1 X2];
Z = rand(1000, 1);

beta = [2;-3]; % make up a beta
y = sin(8*Z) + X*beta + randn(length(X),1);

%----- (2) NW regression of y on Z -------------
ghat_y = Kreg(Z,y,Z);
ehatY = y - ghat_y;

%----- (3) NW regression of X on Z -------------
ehatX = NaN(size(X,1),size(X,2));
for i = 1:size(X,2)
    ghat_X = Kreg(Z,X(:,i),Z);
    ehatX(:,i) = X(:,i) - ghat_X;
end

