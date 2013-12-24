
runs = 10;


% Populations
testTsp('NumberIndividuals', ...
    {10, 20, 30, 50, 75, 100, 200, 300, 400, 500, 625, 750, 1000, 1250, 1500}, runs);

testTsp('NumberSubpopulation', ...
    {1, 2, 3, 5, 7, 10, 15, 20, 30, 40, 50}, runs);


% Migration
subPops = 5;

testTsp('Migration.Interval', ...
    {1, 2, 5, 10, 20, 30}, ...
    runs, 'NumberSubpopulation', subPops);

testTsp('Migration.Rate', ...
    {0.01, 0.02, 0.05, 0.1, 0.15, 0.25}, ...
    runs, 'NumberSubpopulation', subPops);

testTsp('Migration.Topology', ...
    {0, 1, 2}, ...
    runs, 'NumberSubpopulation', subPops);

testTsp('Migration.Selection', ...
    {0, 1}, ...
    runs, 'NumberSubpopulation', subPops);


% Selection
testTsp('Selection.Name', ...
    {'selrws', 'selsus', 'seltour'}, runs);


% Recombination
% TODO


% Mutation
methods = {'mutswap', 'mutmove', 'mutinvert'};

for i=1:length(methods)
    method = methods{i};
    testTsp('Mutation.Rate', ...
        {0.5, 1, 2, 5, 10, 20}, ...
        runs, 'Mutation.Name', method, strcat('_', method));
end

