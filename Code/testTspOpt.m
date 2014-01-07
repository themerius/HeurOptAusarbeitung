function [] = testTspOpt(runs)
%testTspOpt Tests the evolutionary algorithm with the final configuration
%   runs: Number of runs

for j=1:runs
    start = cputime;
    [xnew, GeaOpt] = tspOpt();
    duration = cputime - start;
    [j, duration]

    % write BestObjectiveValue and xnew(1,:) to text file
    fid = fopen('results/tspOpt.txt', 'a');
    if fid ~= -1
        fprintf(fid, '%d', GeaOpt.Run.BestObjectiveValue);
        fprintf(fid, ' %2d', xnew(1,:));
        fprintf(fid, ' %f\n', duration);
        fclose(fid);
    end
end

end
