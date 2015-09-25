% create data
W = 2*rand(1000,1);
Z = 5*rand(1000,1);
X = [W Z];
y = sin(pi*W).*cos(Z) + normcdf(W.*Z) +...
    rand(length(W),1);
x = [linspace(0, 2, 100)' linspace(0, 5, 100)'];

% bivariate kreg
[yhat,h,w,z] = BiKreg(X,y,x);

surf(w,z,yhat)
xlabel('W', 'FontSize', 14);
ylabel('Z', 'FontSize', 14);
zlabel('y', 'FontSize', 14);
hold on
scatter3(W,Z,y)