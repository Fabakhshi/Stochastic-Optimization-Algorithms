% This method should plot the polynomial and the iterates obtained
% using NewtonRaphsonStep (if any iterates were generated).

 function PlotIterations(polynomialCoefficients, iterationValues)
    
    x = linspace(min(iterationValues) - 1, max(iterationValues) + 1, 1000);
    y = polyval(polynomialCoefficients, x);
    
    plot(x, y, 'b-', 'LineWidth', 2);
    hold on;
    
    yIterationValues = polyval(polynomialCoefficients, iterationValues);
    plot(iterationValues, yIterationValues, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
    
    xlabel('x');
    ylabel('f(x)');
    title('Newton-Raphson Iterations');
    grid on;
    
    yline(0, 'k--', 'LineWidth', 1);
    
    hold off;
end
