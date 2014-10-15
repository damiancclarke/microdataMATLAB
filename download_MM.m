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

  %==============================================================================
  %=== (1) Directory Structure
  %==============================================================================
  Top = {'I_Foundation', 'II_DiscreteChoice', 'III_RevealedPreference', ...
         'IV_Dynamics', 'V_NonParametrics', 'VI_Speed'}

  I_Foundation           = {'Intro', 'OptimAgent', 'OptimEcon'}
  II_DiscreteChoice      = {'Games', 'DiscreteChoice'}
  III_RevealedPreference = {'LinearProgramming', 'GARP'}
  IV_Dynamics            = {'Infinite', 'Finite'}
  V_NonParametrics       = {'SemiParametric', 'NonParametric'}
  VI_Speed               = {'Speed'}

  %==============================================================================
  %=== (2) All Programs
  %==============================================================================
  Intro             = {'auto.csv' 'regress.m' 'utility.m'} 
  OptimAgent        = {'budget.m' 'cobbdouglas.m' 'consumptionsim.m'}
  OptimEcon         = {'normalML.m' 'objective.m'}
  DiscreteChoice    = {'BinaryLogitLL.m' 'BinaryLogitSimulatedLL.m' ...
                      'GraphSimulatedData.m' 'Lambda.m MNLogitLL.m' ...
                      'MNLogitSimulatedLL.m' 'MNProbitSimulatedLL.m' ...
                      'MNProbitSimulatedLL_Smoothed.m' 'SimulateBinaryLogit.m' ...
                      'SimulateMNLogit.m' 'SimulateMNProbit.m' ...
                      'SimulateMNProbit_Smoothed.m'}
  BinaryBayesian    = {'BayesianNashLL.m' 'BayesianNashLoss.m' ...
                      'BestResponseLoss.m' 'RunBinaryBayesian.m' ...
                      'SimulateBayesianNash.m' 'SolveBayesianNash.m' ...
                      'SolveBestResponse.m' 'UniqueEquilibriumConstraint.m'...
                      'bvnl.m' 'mvnrnd.m' 'norm_cdf.m' 'stdn_cdf.m'}
  Cournot           = {'BestResponse.m' 'CournotLoss.m' 'Demand.m' ...
                      'Profit.m' 'RunCournot.m' 'SolveNash.m'}
  GARP              = {}
  LinearProgramming = {}
  Finite            = {'backwardsInduc.m' 'finiteStochastic.m' 'flowConstraint.m' ...
                      'flowUtility.m' 'sensitivityBeta.m' 'simulateStochastic.m'}
  Estimation        = {'auto.csv' 'dynamicMoments.m' 'finiteStochastic.m' ...
                      'simulateStochastic.m'}
  Infinite          = {'convergeVF.m' 'iterateGraph.m' 'iteratePolicy.m' 'iterateVF.m'}
  NonParametric     = {'MSE.m' 'ScriptKReg.m' 'ScriptLinearIndex.m' ...
                      'Scriptmultivar_kernel.m' 'cross_val_h.m' 'ghat_ni.m' ...
                      'kreg.m'}
  SemiParametric    = {'ScriptPartiallyLinear.m' 'ichimura.m'}
  Speed             = {'auto.csv' 'bootstrapOLS.m' 'gpuExample.m' 'mailResults.m' ...
                      'parforBasics.m' 'sparseTests.m' 'timeTests.m'}


  %==============================================================================
  %=== (3) Make directories, download
  %==============================================================================
  for s = 1:6
      mkdir(fullfile(parseout.destination,Top{s}));
      section = eval(Top{s});
      for c = 1:length(section)
          chapter = section{c};
          mkdir(fullfile(parseout.destination,Top{s},chapter));

          if strcmp(chapter,'Games')==1
              disp('Games')
              %          elseif chapter=='Infinite'
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

			Chap = strcat(sec,'/',chap)
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

%replace url with:
%https://github.com/damiancclarke/microdataMATLAB/blob/master/
