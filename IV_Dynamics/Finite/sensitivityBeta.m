%**************************************************************************
%*** (1) Calculate optimal consumption for varying Betas: 0<Beta<1
%**************************************************************************
result  = NaN(10,20);

for Beta=1:20
    beta_use=Beta/20;
    result(:,Beta)=fmincon(@(C) flowUtility(T,beta_use,C),...
        guess,A,k1,[],[],lb,ub,[],opt);
end

%**************************************************************************
%*** (2) Graphical output
%**************************************************************************
time  =  1:10;
beta  =  0.05:0.05:1;

subplot(1,2,1)
plot(time, result, 'LineWidth', 2)
xlabel('Time', 'FontSize', 20)
ylabel('Consumption', 'FontSize', 20)

subplot(1,2,2)
surf(time, beta, result')
xlabel('Time', 'FontSize', 20)
ylabel('Beta', 'FontSize', 20)
zlabel('Consumption', 'FontSize', 20)
