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
