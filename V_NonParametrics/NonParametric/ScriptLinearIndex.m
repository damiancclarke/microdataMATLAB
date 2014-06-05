% Class Script: Linear Index Regression 

%% Faking some data 
%..... for example
X = [[1:100]' 100*rand(100,2)];
beta = [1;2;3]; % make up a beta
Xbeta = X*beta;
y = Xbeta.^2 + randn(length(X),1);


%% Find beta using Ichimura estimator 
[bhat, opth] = ichimura(X,y);

%% Find g function
Xhat = X*bhat;

yhat = kreg(Xhat,y,Xbeta,opth);
[Xbsort, Xbord] = sort(Xbeta);
[Xhatsort, Xhatord] = sort(Xhat);

plot(Xbsort, y(Xbord), Xhatsort, yhat(Xhatord));
