function MailResults(ResultsLabel, MatrixOut,...
YourEmail);
%------------------------------------------------
% PURPOSE: Sends an email once containing
%          MATLAB's results
%------------------------------------------------
% INPUTS: ResultsLabel : The name of the results
%                         matrix
%         MatrixOut: A results matrix to send
%         YourEmail: Your email address (in
%                    single quotes)
%------------------------------------------------
% OUTPUT: none
%------------------------------------------------

%----- (1) Basic Email Preferences --------------
mail = 'xxxxxxxxx@gmail.com';
password = 'xxxxxxxxxxxxxxxx';

%----- (2) Advanced settings --------------------
setpref('Internet','SMTP_Server',...
'smtp.gmail.com');
setpref('Internet','E_mail',mail);
setpref('Internet','SMTP_Username',mail);
setpref('Internet','SMTP_Password',password);
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class',...
'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port',...
'465');

%----- (3) Send email along with time spent
%          running program -------
MyToc = toc;
dlmwrite('MatlabResults.csv', MatrixOut,...
'precision','%10.10f')
sendmail(YourEmail,ResultsLabel,...
strcat('toc = ', num2str(MyToc)),...
'MatlabResults.csv')

return