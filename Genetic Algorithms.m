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

function population = InitializePopulation(populationSize,numberOfGenes)

population = zeros(populationSize, numberOfGenes);
  for i = 1:populationSize
   for j = 1:numberOfGenes
    s = rand;
     if (s < 0.5)
      population(i,j)=0;
     else
      population(i,j)=1;
     end
   end
  end

end

% Note: Each component of x should take values in [-a,a], where a = maximumVariableValue.

function x = DecodeChromosome(chromosome,numberOfVariables,maximumVariableValue)
 
 n = numberOfVariables;
 m = size(chromosome,2);
 k = fix(m/n);

 x(1) = 0.0;
 for j = 1:k
 x(1) = x(1) + chromosome(j)*2^(-j);
 end
 x(1) = -maximumVariableValue + 2*maximumVariableValue*x(1)/(1 - 2^(-k));

 x(2) = 0.0;
 for j = 1:k
 x(2) = x(2) + chromosome(j+k)*2^(-j);
 end
 x(2) = -maximumVariableValue + 2*maximumVariableValue*x(2)/(1 - 2^(-k));
 
end

% First compute the function value, then compute the fitness
% value; see also the problem formulation.

function fitness = EvaluateIndividual(x)

 fNumerator1 = (1.5 - x(1) + x(1)*x(2))^2;
 fNumerator2 = (2.25 - x(1) + x(1)*x(2)^2)^2;
 fNumerator3 = (2.625 - x(1) + x(1)*x(2)^3)^2;
 
 g = fNumerator1 + fNumerator2 + fNumerator3;
 
 fitness = 1/(g + 1);

end

function selectedIndividualIndex = TournamentSelect(fitnessList, tournamentProbability, tournamentSize)

    populationSize = size(fitnessList, 1);
    
    iTemp = zeros(tournamentSize, 1);
    
    for j = 1:tournamentSize
        iTemp(j) = 1 + fix(rand * populationSize);
    end
    
    tournamentFitness = fitnessList(iTemp);
   
    [~, maxFitnessIndex] = max(tournamentFitness);
    
    r = rand;
    
    if r < tournamentProbability
        selectedIndividualIndex = iTemp(maxFitnessIndex);
    else
        selectedIndividualIndex = iTemp(randi(tournamentSize));
    end
end

function newIndividuals = Cross(individual1, individual2);

numberOfGenes = size(individual1,2); 

 crossoverPoint = 1 + fix(rand*(numberOfGenes-1));

 newIndividuals = zeros(2,numberOfGenes);
   for j = 1:numberOfGenes
     if (j <= crossoverPoint)
       newIndividuals(1,j) = individual1(j);
       newIndividuals(2,j) = individual2(j);
     else
       newIndividuals(1,j) = individual2(j);
       newIndividuals(2,j) = individual1(j);
     end
   end

 end

 function mutatedIndividual = Mutate(individual, mutationProbability)

numberOfGenes = size(individual,2);
 mutatedIndividual = individual;
 for j = 1:numberOfGenes
   r = rand;
     if (r < mutationProbability)
       mutatedIndividual(j) = 1-individual(j);
     end
 end

 end

