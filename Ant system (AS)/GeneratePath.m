function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)
    numberOfCities = size(pheromoneLevel, 1);
   
    path = zeros(1, numberOfCities);
    unvisitedCities = 1:numberOfCities;
    
    currentCity = randi(numberOfCities);
    path(1) = currentCity;
    unvisitedCities(currentCity) = [];
    
    for step = 2:numberOfCities
        probabilities = zeros(1, length(unvisitedCities));
        for i = 1:length(unvisitedCities)
            city = unvisitedCities(i);
            pheromone = pheromoneLevel(currentCity, city);
            heuristic = visibility(currentCity, city);
            probabilities(i) = (pheromone^alpha) * (heuristic^beta);
        end
        
        probabilities = probabilities / sum(probabilities);
        nextCityIndex = randsample(length(unvisitedCities), 1, true, probabilities);
        nextCity = unvisitedCities(nextCityIndex);
        
        path(step) = nextCity;
        unvisitedCities(nextCityIndex) = [];
        
        currentCity = nextCity;
    end
end
