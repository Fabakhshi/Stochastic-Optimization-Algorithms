% Define mutation probability values, including 0 and 0.02
mutationProbabilityValues = [0, 0.001, 0.005, 0.01, 0.02, 0.1, 0.2, 0.6, 0.8]; 

% Initialize an array to store median performance for each mutation probability
medianPerformance = zeros(size(mutationProbabilityValues));

for i = 1:numel(mutationProbabilityValues)
    mutationProbability = mutationProbabilityValues(i);
    
    % Initialize an array to store median fitness values for 100 runs
    medianFitnessValues = zeros(100, 1);
    
    for run = 1:100
        % Run the genetic algorithm for the current mutation probability
        [maximumFitness, ~] = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                           tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
        % Store the maximum fitness in the array
        medianFitnessValues(run) = maximumFitness;
    end
    
    % Calculate the median fitness for this mutation probability
    medianPerformance(i) = median(medianFitnessValues);
end

% Create a table to display the results with variable names
resultsTable = table(mutationProbabilityValues', medianPerformance', 'VariableNames', {'MutationProbability', 'MedianPerformance'});

% Display the results table
disp(resultsTable);

% Plot median performance as a function of mutation probability
figure;
plot(mutationProbabilityValues, medianPerformance, '-o', 'LineWidth', 2);
xlabel('Mutation Probability');
ylabel('Median Performance (Fitness)');
title('Median Performance vs. Mutation Probability');
grid on;
