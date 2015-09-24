%----- (1) Prompt user to input parameters
Beta = input('Input Beta:');
T    = input('Input time:');
K1   = input('Input initial capital:');
grid = input('Input fineness of grid:');

K    = 0:grid:K1;
V    = [NaN(length(K),T), zeros(length(K),1)];

%----- (2) Loop over possible values of k_{t} and
%          k_{t+1}---
aux = NaN(length(K),length(K),T);
for t = T:-1:1
    for inK = 1:length(K)
        for outK = 1:(inK)
            c = K(inK)-K(outK);
            aux(inK,outK,t) = log(c)+Beta*V(outK,t+1);
        end
    end
    V(:,t)=max(aux(:,:,t),[],2);
end

%-----(3) Calculate optimal results going forward
vf  = NaN(T,1);
kap = [K1; NaN(T,1)];
con = NaN(T,1);

for t=1:T
    vf(t) =V(find(K==kap(t)),t);
    kap(t+1)=K(find(aux(find(K==kap(t)),:,t)==vf(t)));
    con(t) =kap(t)-kap(t+1);
end

%----- (4) Display results ----------------------
[kap([1:T],:),con]
subplot(2,1,1)
plot([1:1:T],[con, kap([2:T+1],:)],'LineWidth',2)
ylabel('Consumption, Capital', 'FontSize', 12)
xlabel('Time', 'FontSize', 12)
legend('Consumption', 'Capital')

subplot(2,1,2)
plot([1:1:T], vf, 'Color', 'red', 'LineWidth', 2)
ylabel('Value Function', 'FontSize', 12)
xlabel('Time', 'FontSize', 12)