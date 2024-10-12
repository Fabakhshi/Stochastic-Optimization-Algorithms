function PlotPath(connection, cityLocation, path)
    numberOfCities = size(cityLocation, 1);
   
    figure;
    
    scatter(cityLocation(:, 1), cityLocation(:, 2), 'filled');
    hold on;
    
    for i = 1:numberOfCities
        currentCity = path(i);
        if i < numberOfCities
            nextCity = path(i + 1);
        else
            nextCity = path(1);
        end
        
        currentCoords = cityLocation(currentCity, :);
        nextCoords = cityLocation(nextCity, :);
        
        plot([currentCoords(1), nextCoords(1)], [currentCoords(2), nextCoords(2)], 'b', 'LineWidth', 2);
    end
    
    xlabel('X-coordinate');
    ylabel('Y-coordinate');
    
    title('TSP Path Visualization');
    
    hold off;
end
