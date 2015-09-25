%----- (1) Starting values ----------------------
y_ = y - X(:,1);
X_ = X(:,2:end);
beta0 = (X_'*X_)\X_'*y_;
beta0 = [1; beta0];

% starting values for the h's (Bowman and
% Azzalini (1997))
x_ = X*beta0;
hx=median(abs(x_-median(x_)))/0.6745*(4/3/N)^0.2;
hy=median(abs(y-median(y)))/0.6745*(4/3/N)^0.2;
h=sqrt(hy*hx);

% param starting value
param0 = [h;beta0];

%----- (2) Optimal constraints ------------------
Aeq = zeros(1, length(param0));
Aeq(2) = 1;
beq = 1;

% lower boound on h
lb = [0;-Inf(length(beta0),1)];

%----- (3) Optimize beta and h ------------------
options = optimset('Display', 'off',...
'Algorithm', 'sqp', 'MaxFunEvals', 1e5,...
'MaxIter', 1e5,'TolX',1e-10, 'TolFun',1e-10);
Param = fmincon(@(p) MSEg(X, y, p), param0,...
[], [], Aeq,beq,lb, [], [] ,options);

opth = Param(1);
optbeta = Param(2:end);

%----- (4) Recover link function ----------------
Xbeta = X*optbeta;
xbeta = [-4:0.1:4]';
ghat = Kreg(Xbeta, y, xbeta, opth);