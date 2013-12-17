function [] = testTsp(name, values, runs)
%testTsp Summary of this function goes here
%   Detailed explanation goes here

N = length(values);

%matlabpool open

for i=1:N
%parfor i=1:N
    for j=1:runs
        val = values(N+1-i);
        [val, j]
        [xnew, GeaOpt] = tsp(name, val);
        
        % write BestObjectiveValue and xnew(1,:) to text file
        fid = fopen(strcat('results/', name, '_', num2str(val), '.txt'), 'a');
        if fid ~= -1
          fprintf(fid, '%d', GeaOpt.Run.BestObjectiveValue);
          fprintf(fid, ' %2d', xnew(1,:));
          fprintf(fid, '\n');
          fclose(fid);
        end
    end
end

%matlabpool close

end
