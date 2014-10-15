function downloadDynamic(varargin)
 % Download the files associated with the dynamic chapters of the
 % Computational Economics course.  This program will download all
 % .m files referred to in the notes, and store them locally on
 % your machine.  You can either specify the directoy where you
 % want your files saved as an argument, or specify no argument,
 % and the files will be saved in the current directory.
 % 
 % Example:
 %		download_MM
 % which downloads all files and stores them in the current directory,
 %
 %		download_MM(DIR)
 % which downloads the files and stores them in the directory DIR

   p = inputParser;
   addOptional(p, 'destination', pwd, @ischar)	

   p.parse(varargin{:});

   parseout = p.Results;

   if exist(parseout.destination,'dir') ~= 7
        error(['The folder: ''',parseout.destination, ''', does not exist.']);
   end

   %==============================================================================
   %=== (1) Directory Structure
   %==============================================================================
   Top = {'IV_Dynamics'};

   I_Foundation           = {'Intro', 'OptimAgent', 'OptimEcon'};
   IV_Dynamics            = {'Infinite', 'Finite'};

   %==============================================================================
   %=== (2) All Programs
   %==============================================================================
   Intro             = {'auto.csv' 'regress.m' 'utility.m'};
   OptimAgent        = {'budget.m' 'cobbdouglas.m' 'consumptionsim.m'};
   OptimEcon         = {'normalML.m' 'objective.m'};
   Finite            = {'backwardsInduc.m' 'finiteStochastic.m' 'flowConstraint.m' ...
                       'flowUtility.m' 'sensitivityBeta.m' 'simulateStochastic.m'};
   Estimation        = {'auto.csv' 'dynamicMoments.m' 'finiteStochastic.m' ...
                       'simulateStochastic.m'};
   Infinite          = {'convergeVF.m' 'iterateGraph.m' 'iteratePolicy.m' 'iterateVF.m'};

   %==============================================================================
   %=== (3) Make directories, download
   %==============================================================================
   for s = 1:length(Top)
       mkdir(fullfile(parseout.destination,Top{s}));
       section = eval(Top{s});
       for c = 1:length(section)
           chapter = section{c};
           mkdir(fullfile(parseout.destination,Top{s},chapter));

           if strcmp(chapter,'Games')==1
               disp('Games')
           else
               download(eval(chapter),Top{s},chapter)
           end
       end
   end
   mkdir(fullfile(parseout.destination,'IV_Dynamics','Infinite','Estimation'))
   download(Estimation,'IV_Dynamics','Infinite/Estimation')


   function download(filelist,sec,chap)
     for f = 1:length(filelist)
       file = filelist{f};

       Chap = strcat(sec,'/',chap);
       filesave = fullfile(parseout.destination,Chap,file);

       [fileconts, filestatus] = ...	
       urlread(['http://users.ox.ac.uk/~ball3491/MicrodataMatlab/',...
       sec,'/',chap,'/',file]);

       if ~filestatus
         fprintf('Unable to download %s.\n', file);
			else
				fid = fopen(filesave,'w');
				fwrite(fid,fileconts);
				fclose(fid);
				fprintf('Successfully downloaded: ''%s''.\n', filesave);
			end	
		end
	end
end