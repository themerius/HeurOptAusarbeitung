function [xnew, GeaOpt] = tsp(name, value, args)
%tsp Runs TSP
%   name:  Parameter to change
%   value: Value for the parameter
%   args:  Additional parameter/value pairs

% DEMO for optimizing 'TSP Library' examples
%
% This script provides an example for defining non-default parameters
% for an optimization. Here is the highest level entry point into the
% GEA Toolbox.
% This demo uses the geaoptions structure for option definition.
%
% Syntax:  demotsplib
%
% Input parameter:
%    no input parameter
%
% Output parameter:
%    no output parameter
%
% See also: objtsplib, geaoptset, geamain2

% Author:       Hartmut Pohlheim
% History:      20.07.99    file created

% Modified by:  Wilhelm Erben, May 2012

   include

% Define special parameters
   GeaOpt = geaoptset(  'VariableFormat',           5 ...           % Use permutation variables  
                      , 'NumberSubpopulation',      1 ...           % Number of subpopulation
                      , 'NumberIndividuals',        50 ...          % Number of individuals per subpopulation
                      , 'Selection.Name',           'selrws' ...    % Define the selection function
                      , 'Selection.GenerationGap',  1 ...           % Set generation gap to 100%     
                      , 'Recombination.Name',       'recpm' ...     % Define the recombination function
                      , 'Mutation.Name',            'mutswap' ...   % Define the mutation functions
                      , 'Mutation.Rate',            10 ...          % Define the mutation rate                      
                      ...
                      , 'Output.TextInterval',      0 ...           % Text output every 100 generations
                      , 'Output.GrafikInterval',    0 ...            % Grafic results every 100 generations
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

% Override variable for test runs
   nArgs = length(args) - 1; % last element may contain a part of the filename
   for k = 1:2:nArgs
      GeaOpt = geaoptset( GeaOpt , args{k}, args{k+1} );
      %DEBUG { args{k}, args{k+1} }
   end

   GeaOpt = geaoptset( GeaOpt , name, value);

% Call main GEA function
   [xnew, GeaOpt] = geamain2(objfun, GeaOpt, VLUB, []);
   %DEBUG xnew = zeros(10,10);

% End of script
end
