% Class Script: Kernel Regression with Structures
clear; clc;

%% Faking some data 
%..... for example
X = [1:100]';
y = sin(0.1*X) + randn(length(X),1);

%% Prepare structure
K = ['Gaussian    '; 'Epanechnikov'; 'Uniform     '];
K = cellstr(K);
K_ = length(K);
h = [1e-3; 3; 6; 40];
h_ = length(h);
Kresults = struct('name', [], 'h', [], 'yhat', []);

%% Kernel regression
for k =1 : K_
    for hh = 1 : h_
        Kresults((k-1)*h_ + hh).name = K(k);
        Kresults((k-1)*h_ + hh).h = h(hh);
        Kresults((k-1)*h_ + hh).yhat = kreg(X, y, X, h(hh), K(k));
    end
end

%% Plot output
% Bandwidth
figure;
for hh = 1 : h_
    subplot(2, 2, hh);
    scatter(X,y);
    hold on
    plot(X, Kresults(hh).yhat,'Color','r', 'LineWidth', 1.5);
    hold off
    title(['Bandwidth =' num2str(h(hh))])
    xlabel('X','FontSize', 14); ylabel('y','FontSize', 14);
end

figure;
for k = 1 : K_
    subplot(3, 1, k);
    scatter(X,y);
    hold on
    plot(X, Kresults((k-1)*h_ + 3).yhat,'Color','r', 'LineWidth', 1.5);
    hold off
    if k ==1
        title('Gaussian','FontSize',14)
    elseif k==2
        title('Epanechnikov','FontSize',14)
    else
        title('Uniform','FontSize',14)
    end
    xlabel('X','FontSize', 14); ylabel('y','FontSize', 14);
end

%% Kernel regression with an optimal bandwidth determined by cross
% validation 
opth = cross_val_h(X,y,h(3));
yhat_cv = kreg(X,y,X,opth);
figure;
plot(X,yhat_cv,'-g', 'LineWidth', 1.5);


