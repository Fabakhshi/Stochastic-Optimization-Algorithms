% Here, the polynomial 10 - 2x - x^2 + x^3 is defined.
% Note: This is just an example! You can (and should) try
% with many different polynomials to make sure that your
% program can handle all cases.

polynomialCoefficients = [10 -2 -1 1];
startingPoint = 2;
tolerance = 0.0001;
iterationValues = RunNewtonRaphson(polynomialCoefficients, startingPoint, tolerance);
PlotIterations(polynomialCoefficients,iterationValues)

% This function should run the Newton-Raphson method, making use of the
% other relevant functions (StepNewtonRaphson, DifferentiatePolynomial, and
% GetPolynomialValue). Before returning iterationValues any non-plottable values 
% (e.g. NaN) that can occur if the method fails (e.g. if the input is a
% first-order polynomial) should be removed, so that only values that
% CAN be plotted are returned. Thus, in some cases (again, the case of
% a first-order polynomial is an example) there may be no points to plot.

function iterationValues = RunNewtonRaphson(polynomialCoefficients, startingPoint, tolerance)

    iterationValues = startingPoint;
    xStart = startingPoint;
    maxIterations = 100;
    
    for iteration = 1:maxIterations
        
        fPrime = GetPolynomialValue(xStart, DifferentiatePolynomial(polynomialCoefficients, 1));
        fDoublePrime = GetPolynomialValue(xStart, DifferentiatePolynomial(polynomialCoefficients, 2));
        
        xNext = StepNewtonRaphson(xStart, fPrime, fDoublePrime);
        
        if abs(xNext - xStart) < tolerance
           iterationValues(end+1) = xNext;  
           break;
        end

        iterationValues(end+1) = xNext;

        xStart = xNext;

    end
end

% This function should return the value of the polynomial f(x) = a0x^0 + a1x^1 + a2x^2 ...
% where a0, a1, ... are obtained from polynomialCoefficients.

function value = GetPolynomialValue(x, polynomialCoefficients)
    value = 0;
    n = length(polynomialCoefficients);

    for i = 1:n
        value = value + polynomialCoefficients(i) * x^(i-1);
    end
end

   % This method should return the coefficients of the k-th derivative (defined by
% the derivativeOrder) of the polynomial given by the polynomialCoefficients (see also GetPolynomialValue)


function derivativeCoefficients = DifferentiatePolynomial(polynomialCoefficients, derivativeOrder)

    if derivativeOrder < 0
        error('Derivative order must be non-negative.');
    end
    
    derivativeCoefficients = polynomialCoefficients;

    for k = 1:derivativeOrder
        n = length(derivativeCoefficients);
        
        if n == 1
            derivativeCoefficients = 0;
            return;
        end
        
        newCoefficients = zeros(1, n - 1);
        for i = 2:n
            newCoefficients(i - 1) = derivativeCoefficients(i) * (i - 1);
        end
        
        derivativeCoefficients = newCoefficients;
    end
    
end

% This method should perform a single step of the Newton-Raphson method.
% Note: In cases where the step cannot be completed, e.g. if f" = 0, a
% clear error message should be given.
function xNext = StepNewtonRaphson(x, fPrime, fDoublePrime)
 
    if fDoublePrime == 0
        disp("Second derivative is zero. Newton-Raphson method cannot continue.");
        xNext = NaN;
    end
    
    xNext = x - (fPrime / fDoublePrime);
    
end

% This method should plot the polynomial and the iterates obtained
% using NewtonRaphsonStep (if any iterates were generated).

 function PlotIterations(polynomialCoefficients, iterationValues)
    xRange = linspace(min(iterationValues) - 1, max(iterationValues) + 1, 100);
    yValues = arrayfun(@(x) GetPolynomialValue(x, polynomialCoefficients), xRange);
    
    figure; 
    plot(xRange, yValues, 'b-', 'LineWidth', 2);
    hold on; 
    
    if ~isempty(iterationValues)
        yIterValues = arrayfun(@(x) GetPolynomialValue(x, polynomialCoefficients), iterationValues);
        plot(iterationValues, yIterValues, 'ko', 'MarkerSize', 8, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'none');  % Plot iterations as empty black points
    end

    xlabel('x');
    ylabel('f(x)');
    title('Newton-Raphson Iterations');

    if ~isempty(iterationValues)
        legend('Polynomial', 'Iterations', 'Location', 'Best');
    else
        legend('Polynomial', 'Location', 'Best');
    end
    
    grid on;
    xlim([min(xRange), max(xRange)]);
    ylim([min(yValues) - 1, max(yValues) + 1]); 

    hold off;
end
