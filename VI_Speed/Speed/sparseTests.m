%===============================================================================
% Why and when do we care about sparse matrices in MATLAB?
%===============================================================================
% (1) Set up test size, prefill results vector
%===============================================================================
N 		= 1000;
factor		= NaN(N,2);

%===============================================================================
% (2) Test memory improvement of sparse matrix versus non-sparse as N increases
%===============================================================================
for i = 1:N
	naive	= eye(i);
	cool	= speye(i);

	mem_n   = whos('naive');
	mem_n 	= mem_n.bytes;
	mem_c	= whos('cool');
	mem_c 	= mem_c.bytes;

	factor(i,1) = mem_n/mem_c;
	clear naive cool
end

%===============================================================================
% (3) Test time improvement for sparse versus non-sparse
%===============================================================================
for i = 1:N
	naive	= eye(i);
	cool	= speye(i);

        tic; inv(naive); n=toc;
        tic; inv(cool);  c=toc;

        factor(i,2) = n/c;
        clear naive cool
end

%===============================================================================
% (4) Graphical output
%===============================================================================
subplot(2,1,1)
plot(1:N,factor(:,1), 'r', 'LineWidth', 2)
xlabel('Size of Matrix (N\times N)', 'FontSize', 10)
ylabel('Proportional Saving in Memory', 'FontSize', 10)
title('The Advantage of Using Sparse Commands As N\rightarrow 1000',...
			'FontSize', 14)

subplot(2,1,2)
scatter(1:N,factor(:,2), 'LineWidth', 2)
xlabel('Inverse of Matrix (N\times N)', 'FontSize', 10)
ylabel('Proportional Saving in Time', 'FontSize', 10)
