function [u,c] = budget(P,I,X)
%Budget presents the budget constraint faced by an individual, and
%calculates their optimal consumption based upon a Cobb-Douglas utility
%function defined in the function utility.m
%
%The syntax of the function is budget(P,I,X) and the function 
%accepts as arguments a 2*N vector of prices, P, the total
%income, I, and the parameters accepted by the fmincon command.  
%The fmincon options X must be specified precisely as per the
%syntax of fmincon.
%
%see also fmincon


%************************************************************
%*** (1) Import relevant parameters from function
%************************************************************
p1  =   P(1);
p2  =   P(2);
lb  =   [0,0];
ub  =   [I/p1,I/p2];

%************************************************************
%*** (2) Determine utility maximising consumption
%************************************************************
[c, u] =   fmincon(@cobbdouglas,X,P,I,[],[],lb,ub);

%************************************************************
%*** (3) Create graphical output
%************************************************************
x2  =   0:I/p2;
x1  =   (I-p2.*x2)./p1;
fig =   plot(x1,x2,'LineWidth',2);
hold on

x1  =   u.^2./x2;
axis([0,I/p1,0,I/p2]);
plot(x1,x2, 'color','r','LineWidth',2)


xlabel('quantity of good x_1', 'FontSize', 14);
ylabel('quantity of good x_2', 'FontSize', 14);
title('Cobb-Douglas Utility Maximisation', 'FontSize',16);

return
