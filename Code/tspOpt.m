function [xnew, GeaOpt] = tspOpt()
%tsp Runs TSP Optimal Values

   include

% Define special parameters
   GeaOpt = geaoptset(  'VariableFormat',           5 ...           % Use permutation variables  
                      , 'NumberSubpopulation',      5 ...           % Number of subpopulation
                      , 'NumberIndividuals',        100 ...         % Number of individuals per subpopulation
                      , 'Migration.Interval',       1 ...
                      , 'Migration.Rate',           0.25 ...
                      , 'Migration.Topology',       1 ...
                      , 'Migration.Selection',      1 ... 
                      ...
                      , 'Selection.Name',           'seltour' ...   % Define the selection function
                      , 'Selection.GenerationGap',  1 ...           % Set generation gap to 100%     
                      , 'Recombination.Name',       'recox' ...     % Define the recombination function
                      , 'Mutation.Name',            'mutmove' ...   % Define the mutation functions
                      , 'Mutation.Rate',            1.25 ...        % Define the mutation rate                      
                      ...
                      , 'Output.TextInterval',      0 ...           % Text output every 100 generations
                      , 'Output.GrafikInterval',    0 ...           % Grafic results every 100 generations
                      , 'Output.StatePlotInterval', 0            ...
                      , 'Output.StatePlotFunction', 'plottsplib' ...
                      , 'Termination.MaxGen',       400 ...         % Terminate after xx generations
                      , 'Termination.Method',       1 ...           % Termination method to use
                      );

% Define special parameters for saving results
   FileNameBase = 'test_tsplib';
   GeaOpt = geaoptset( GeaOpt ...
                      , 'Output.SaveTextInterval',     0 ...                    % Text to File every xx generations
                      , 'Output.SaveTextFilename',    [FileNameBase '.txt'] ... % Filename of result file, absolut or relative path may be included
                      , 'Output.SaveBinDataInterval',  0 ...                    % Binary Data to File every xx generations
                      , 'Output.SaveBinDataFilename', [FileNameBase '.mat'] ... % Filename of binary file, absolut or relative path may be included
                      );

% Define objective function to use
   GeaOpt = geaoptset( GeaOpt , 'System.ObjFunFilename', 'objtsplib');
   objfun = [];

% Define global variables
   global TSPLIB_FILENAME;
   global TSPLIB_NAME;

% Define the TSPLIB example to solve/Reset some variables
   TSPLIB_FILENAME = 'bays29'; TSPLIB_NAME = '';
   tsp_readlib(TSPLIB_FILENAME);

% Set additional parameter
   GeaOpt = geaoptset( GeaOpt , 'System.ObjFunAddPara', {TSPLIB_NAME});

% Get variable boundaries from objective function
   VLUB = geaobjpara(GeaOpt.System.ObjFunFilename, 1, GeaOpt.System.ObjFunAddPara);
   GeaOpt = geaoptset( GeaOpt , 'System.ObjFunVarBounds', VLUB);
   VLUB = [];

% Call main GEA function
   [xnew, GeaOpt] = geamain2(objfun, GeaOpt, VLUB, []);
   %DEBUG xnew = zeros(10,10);

% End of script
end
