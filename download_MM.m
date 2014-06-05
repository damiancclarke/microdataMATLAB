function download_MM(varargin)
% Download the files associated with the book Microdata for Matlab, by Abi Ada-
% ms, Damian Clarke, and Simon Quinn.  This program will download all .m files
% referred to in the book, and store them locally on your machine.  You can ei-
% ther specify the directory where you want the files saved as an argument, or
% specify no argument, and the files will be saved in the current directory.
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

	Chapter2 = {'regress.m'};
	Chapter3 = {'CLT.m' 'budget.m' 'normalML.m' 'utility.m'};
	Chapter9 = {'Finite_stochastic.m' 'SimulateStochastic.m' ...
							'backwards_induc.m' 'backwards_induc_prod.m' ... 
							'consump_graph.m' 'flowconstraint.m' 'flowutility.m'};
	Chapter10 = {''};

	mkdir(fullfile(parseout.destination,'Chapter2'));
	download(Chapter2,2);

	mkdir(fullfile(parseout.destination,'Chapter3'));
	download(Chapter3,3);

	mkdir(fullfile(parseout.destination,'Chapter9'));
	download(Chapter9,9);

	%mkdir(fullfile(parseout.destination,'Chapter10'))
	%download(Chapter10,10);

	function download(filelist,num)
		for f = 1:length(filelist)
			file = filelist{f};

			Chap = strcat('Chapter', num2str(num));
			filesave = fullfile(parseout.destination,Chap,file);

			[fileconts, filestatus] = ...	
			urlread(['http://users.ox.ac.uk/~ball3491/MicrodataMatlab/Chapter',...
			num2str(num),'/',file]);

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

%replace url with:
%https://github.com/damiancclarke/microdataMATLAB/blob/master/
