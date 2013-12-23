function [] = testTsp(name, values, runs, varargin)
%testTsp Tests different values for a parameter of TSP
%   name:     Parameter to change
%   values:   Values for the parameter
%   runs:     Number of runs to run for each value
%   varargin: Additional parameter/value pairs

N = length(values);

%matlabpool open

for i=1:N
%parfor i=1:N
    for j=1:runs
        val = values{N+1-i};
        start = cputime;
        [xnew, GeaOpt] = tsp(name, val, varargin);
        duration = cputime - start;
        [val, j, duration]

        % write BestObjectiveValue and xnew(1,:) to text file
        fid = fopen(strcat('results/', name, '_', num2str(val), '.txt'), 'a');
        if fid ~= -1
          fprintf(fid, '%d', GeaOpt.Run.BestObjectiveValue);
          fprintf(fid, ' %2d', xnew(1,:));
          fprintf(fid, ' %f\n', duration);
          fclose(fid);
        end
    end
end

%matlabpool close

end
