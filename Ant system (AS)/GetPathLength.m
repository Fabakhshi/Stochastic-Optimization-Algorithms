function pathLength = GetPathLength(path, cityLocation)
    numberOfCities = length(path);
    pathLength = 0;

    for i = 1:numberOfCities - 1
        fromCity = path(i);
        toCity = path(i + 1);
        distance = norm(cityLocation(fromCity, :) - cityLocation(toCity, :));
        pathLength = pathLength + distance;
    end

    fromCity = path(numberOfCities);
    toCity = path(1);
    distance = norm(cityLocation(fromCity, :) - cityLocation(toCity, :));
    pathLength = pathLength + distance;
end
