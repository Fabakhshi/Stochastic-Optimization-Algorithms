function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection, pathLengthCollection)
    numberOfAnts = size(pathCollection, 1);
    numberOfCities = size(pathCollection, 2);
    
    deltaPheromoneLevel = zeros(numberOfCities, numberOfCities);
    
    Q = 1.0;
    
    for k = 1:numberOfAnts
        path = pathCollection(k, :);
        pathLength = pathLengthCollection(k);
        
        for i = 1:numberOfCities - 1
            fromCity = path(i);
            toCity = path(i + 1);
            
            deltaPheromoneLevel(fromCity, toCity) = deltaPheromoneLevel(fromCity, toCity) + Q / pathLength;
            deltaPheromoneLevel(toCity, fromCity) = deltaPheromoneLevel(fromCity, toCity); 
        end
        
        startCity = path(1);
        deltaPheromoneLevel(toCity, startCity) = deltaPheromoneLevel(toCity, startCity) + Q / pathLength;
        deltaPheromoneLevel(startCity, toCity) = deltaPheromoneLevel(toCity, startCity); 
    end
end
