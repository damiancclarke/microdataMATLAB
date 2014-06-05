function [freq,theoretical,num] = benfordLaw(txtfile)
% freq = benfordsLaw(txtfile) accepts a txt file as input and scans
% to find occurrences of each number (1-9) and compares the frequency
% of occurrence with that of Bedford's Law.

%======================================================================
% (1) generate numbers and theoretical prob
%======================================================================
num  = 1:9';
count = NaN(9,1);
theoretical=log10(1+1./num)';

%======================================================================
% (2) Determine frequency of occurence in txt
%======================================================================
filein = fopen(txtfile,'r');
filec  = fscanf(filein, '%c');

for i=1:9
    count(i,1) = size(strfind(filec,num2str(i)),2);
end

freq = count/sum(count);

%======================================================================
% (3) Plot
%======================================================================
figure
width1=0.6;
bar(num,theoretical,width1,'FaceColor',[0.2,0.2,0.5],...
    'EdgeColor','none');

hold on
width2 = width1/2;
bar(num,freq,width2,'FaceColor',[0,0.7,0.7],...
                    'EdgeColor',[0,0.7,0.7]);
hold off
legend('Theoretical','Actual')
title('Does Benford''s Law Hold Here?','FontSize',14)

return