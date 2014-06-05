function mailResults(ResultsLabel, MatrixOut,YourEmail);
% mailResults(ResultsLabel, MatrixOut,YourEmail) sends matrix of MATLAB 
% results to the email address specified in YourEmail.  This is to 
% include at the end of a long script, as it will send an email upon
% termination
%
% see also sendmail

%==============================================================================
%=== (1) Basic Email Preferences
%==============================================================================
mail        = 'matlaboxford@gmail.com'; 
password    = 'matlabmatlab';

%==============================================================================
%=== (2) Advanced settings
%==============================================================================
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','E_mail',mail);
setpref('Internet','SMTP_Username',mail);
setpref('Internet','SMTP_Password',password);
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');

%==============================================================================
%=== (3) Send email along with time spent running program
%==============================================================================
MyToc   = toc;
dlmwrite('MatlabResults.csv', MatrixOut, 'precision', '%10.10f')
sendmail(YourEmail,ResultsLabel, ...
            strcat('toc = ', num2str(MyToc)), 'MatlabResults.csv')

return

