function tspFigure = InitializeTspPlot(cityLocation, range)
    
    tspFigure = figure;
    
    set(tspFigure, 'DoubleBuffer', 'on');
    
    axis([range(1), range(2), range(3), range(4)]);
    
    axis square;
    
    grid on;
    
    hold on;
    scatter(cityLocation(:, 1), cityLocation(:, 2), 'o', 'filled');
    
    % Label the cities with their indices (1, 2, 3, ...)
    for i = 1:size(cityLocation, 1)
        text(cityLocation(i, 1), cityLocation(i, 2), num2str(i));
    end
    
    title('TSP City Locations');
    
    xlabel('X Coordinate');
    ylabel('Y Coordinate');
    
    hold off;
end
