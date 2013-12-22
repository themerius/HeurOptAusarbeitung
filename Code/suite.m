
runs = 10;

testTsp('NumberIndividuals', ...
    [10, 20, 30, 50, 75, 100, 200, 300, 400, 500, 625, 750, 1000, 1250, 1500], runs);

testTsp('NumberSubpopulation', ...
    [1, 2, 3, 5, 7, 10, 15, 20, 30, 40, 50], runs);


% http://www.geatbx.com/docu/options-05.html
subPops = 5;

testTsp('Migration.Interval', ...
    [1, 2, 5, 10, 20, 30], ...
    runs, 'NumberSubpopulation', subPops);

testTsp('Migration.Rate', ...
    [0.01, 0.02, 0.05, 0.1, 0.15, 0.25], ...
    runs, 'NumberSubpopulation', subPops);

testTsp('Migration.Topology', ...
    [0, 1, 2], ...
    runs, 'NumberSubpopulation', subPops);

testTsp('Migration.Selection', ...
    [0, 1], ...
    runs, 'NumberSubpopulation', subPops);