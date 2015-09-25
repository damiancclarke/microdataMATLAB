%-----(1) Set up test size, prefill results vector
N      = 1000;
Factor = NaN(N,2);

%-----(2) Test memory improvement of sparse v
%         non-sparse -----
for i = 1:N
    naive = eye(i);
    cool = speye(i);

    mem_n = whos('naive');
    mem_n = mem_n.bytes;
    mem_c = whos('cool');
    mem_c = mem_c.bytes;
    
    Factor(i,1) = mem_n/mem_c;
    clear naive cool
end

%----- (3) Test speed improvement of sparse v
%          non-sparse ------
for i = 1:N
    naive = eye(i);
    cool = speye(i);

    tic; inv(naive); n=toc;
    tic; inv(cool); c=toc;

    Factor(i,2) = n/c;
    clear naive cool
end

%----- (4) Graphical output ---------------------
subplot(2,1,1)
plot(1:N,Factor(:,1), 'LineWidth', 2)
xlabel('Size of Matrix (N\times N)',...
       'FontSize', 10)
ylabel('Proportional Saving in Memory',...
       'FontSize', 10)

subplot(2,1,2)
scatter(1:N, Factor(:,2), 'LineWidth',2)
xlabel('Size of Matrix (N\times N)',...
       'FontSize', 10)
ylabel('Proportional Saving in Time',...
       'FontSize', 10)