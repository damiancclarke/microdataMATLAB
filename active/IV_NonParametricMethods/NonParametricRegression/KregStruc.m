% Script: Kernel Regression with Structures
%clear; clc;

%----- (1) Simulate data ------------------------
X = [1:100]';
y = sin(0.1*X) + randn(length(X),1);

%----- (2) Prepare structure array --------------
K = {'Gaussian', 'Uniform', 'Epanechnikov'};
% K is a 'cell array'
K_ = length(K);
h = [1e-3; 3; 6; 40];
h_ = length(h);
Kresults = struct('name',[],'h',[],'yhat',[]);

%----- (3) Perform kernel regression! -----------
for k =1 : K_ % cycle over kernel choices

    kernel = K{k};
    
    for hh = 1 : h_ % cycle over bandwidth choices

        bandwidth = h(hh);
        
        % record name and bandwidth
        Kresults((k-1)*h_ + hh).name = kernel;
        Kresults((k-1)*h_ + hh).h = bandwidth;
        
        % perform kernel regression
        Kresults((k-1)*h_ + hh).yhat = ...
            Kreg(X, y, X, bandwidth, kernel);
        
    end
end

%----- (4) Plot output --------------------------
% Bandwidth
figure;
for hh = 1 : h_
    subplot(2, 2, hh);
    scatter(X,y);
    hold on
    plot(X, Kresults(hh).yhat,'Color','r',...
         'LineWidth', 1.5);
    hold off
end

% Kernel function
figure;
for k = 1 : K_
    subplot(3, 1, k);
    scatter(X,y);
    hold on
    plot(X, Kresults((k-1)*h_+3).yhat,'Color','r');
    hold off
end