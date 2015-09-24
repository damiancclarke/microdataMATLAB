%----- (1) Set-up parameters, simulate shocks ---
people  =  100;

epsilon = randi(2,people,T+1);
epsilon(epsilon==1) = -2;

vf      = NaN(people,T);
kap     = [K1*ones(people,1) NaN(people,T)];
con     = NaN(people,T);

%----- (2) Determine consumption based on
%          simulated shocks ----
for p=1:people
    for t=1:T
        position = round(kap(p,t)/grid+1);
        vf(p,t)  = V(position,t);
        kap(p,t+1) = K(find(aux(position,:,t)...
                            ==vf(p,t)));
        con(p,t) = kap(p,t)-(kap(p,t+1)/Theta)^...
            (1/Alpha);
        kap(p,t+1) = kap(p,t+1)+epsilon(p,t+1);
    end
end

%----- (3) Output ------------------------------
plot([1:1:T], con)
ylabel('Consumption', 'FontSize', 12)
xlabel('Time', 'FontSize', 12)
title('Simulated Consumption Paths',...
'FontSize', 16)

figure(2)
hist(sum(con,2))
title('Lifetime Consumption', 'FontSize', 16)