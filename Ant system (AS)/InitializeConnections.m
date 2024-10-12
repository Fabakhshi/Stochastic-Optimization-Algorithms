function connection = InitializeConnections(cityLocation)
    numberOfCities = size(cityLocation, 1);
    connection = zeros(numberOfCities, numberOfCities);
    
    for i = 1:numberOfCities
        for j = 1:numberOfCities
            if i ~= j
                distance = norm(cityLocation(i, :) - cityLocation(j, :));
                connection(i, j) = distance;
            end
        end
    end
end