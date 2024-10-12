%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter specifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numberOfRuns = 100;                % Do NOT change
populationSize = 100;              % Do NOT change
maximumVariableValue = 5;          % Do NOT change (x_i in [-a,a], where a = maximumVariableValue)
numberOfGenes = 50;                % Do NOT change
numberOfVariables = 2;		   % Do NOT change
numberOfGenerations = 300;         % Do NOT change
tournamentSize = 2;                % Do NOT change
tournamentProbability = 0.75;      % Do NOT change
crossoverProbability = 0.8;        % Do NOT change


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Batch runs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define more runs here (pMut < 0.02) ...
mutationProbabilitiesLess = [0.001, 0.005, 0.01]; % Add more values as needed
maximumFitnessListsLess = zeros(numberOfRuns, numel(mutationProbabilitiesLess));

for j = 1:numel(mutationProbabilitiesLess)
    mutationProbability = mutationProbabilitiesLess(j);
    sprintf('Mutation rate = %0.5f', mutationProbability)
    
    for i = 1:numberOfRuns 
        [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                           tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
        sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
        maximumFitnessListsLess(i, j) = maximumFitness;
    end
    
end


mutationProbability = 0.02;
sprintf('Mutation rate = %0.5f', mutationProbability)
maximumFitnessList002 = zeros(numberOfRuns,1);
for i = 1:numberOfRuns 
 [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                       tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
 sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
  maximumFitnessList002(i,1) = maximumFitness;
end


% ... and here (pMut > 0.02)
mutationProbabilitiesGreater = [0.05, 0.1, 0.2]; % Add more values as needed
maximumFitnessListsGreater = zeros(numberOfRuns, numel(mutationProbabilitiesGreater));

for j = 1:numel(mutationProbabilitiesGreater)
    mutationProbability = mutationProbabilitiesGreater(j);
    sprintf('Mutation rate = %0.5f', mutationProbability)
    
    for i = 1:numberOfRuns 
        [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                           tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
        sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
        maximumFitnessListsGreater(i, j) = maximumFitness;
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Summary of results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add more results summaries here (pMut < 0.02) ...
average = mean(maximumFitnessListsLess(:, j));
medianValue = median(maximumFitnessListsLess(:, j));
stdValue = sqrt(var(maximumFitnessListsLess(:, j)));
sprintf('PMut = %0.5f (Less than 0.02): Median: %0.10f, Average: %0.10f, STD: %0.10f', mutationProbability, medianValue, average, stdValue)


average002 = mean(maximumFitnessList002);
median002 = median(maximumFitnessList002);
std002 = sqrt(var(maximumFitnessList002));
sprintf('PMut = 0.02: Median: %0.10f, Average: %0.10f, STD: %0.10f', median002, average002, std002)


% ... and here (pMut > 0.02)
average = mean(maximumFitnessListsGreater(:, j));
medianValue = median(maximumFitnessListsGreater(:, j));
stdValue = sqrt(var(maximumFitnessListsGreater(:, j)));
sprintf('PMut = %0.5f (Greater than 0.02): Median: %0.10f, Average: %0.10f, STD: %0.10f', mutationProbability, medianValue, average, stdValue)