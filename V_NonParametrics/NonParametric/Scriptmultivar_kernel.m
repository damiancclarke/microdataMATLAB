% Class Script- multivariate kernel code 

X = rand(1000,1);
Z = 2*rand(1000,1);
y = sin(10*X.*Z) + 0.1*rand(length(X),1);
n = length(y);

% create meshgrid for points of evaluation
[x,z] = meshgrid(0:0.1:1, 0:0.2:2);
N = size(x,1);

% kernel and h
krnl = @(u) exp(-(u.*u)/2)/sqrt(2*pi);

hx=median(abs(X-median(X)))/0.6745*(4/3/n)^0.2;
hz=median(abs(Z-median(Z)))/0.6745*(4/3/n)^0.2;
hy=median(abs(y-median(y)))/0.6745*(4/3/n)^0.2;
hx=sqrt(hy*hx); 
hz=sqrt(hy*hz);

% create multivariate kernel 
KX = NaN(length(y),size(x,1));
KZ = NaN(length(y),size(z,1));

for x_ = 1 : N
    xi = x(1,x_);
    ux = (X - xi)/hx;
    Kux = krnl(ux);
    KX(:,x_) = Kux;
end

for z_ = 1 : N
    zi = z(z_, 1);
    uz = (Z - zi)/hz;
    Kuz = krnl(uz);
    KZ(:,z_) = Kuz;
end

% putting together
yhat = NaN(size(x,1), size(x,2));
for i = 1 : N
    for j = 1 : N
        Ku = KX(:,i).*KZ(:,j);
        yhat(j,i) = sum(Ku.*y)/sum(Ku);
    end
end

surf(x,z,yhat)
xlabel('X', 'FontSize', 14);
ylabel('Z', 'FontSize', 14);
zlabel('y', 'FontSize', 14);
hold on 
scatter3(X,Z,y)
