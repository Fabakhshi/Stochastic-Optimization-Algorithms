% Here, the polynomial 10x^3 - 2x^2 - x^2 + x^3  is defined.
%
% Note: This is just an example! You can (and should) try
% with many different polynomials to make sure that your
% program can handle all cases.
%

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
    
    maxIterations = 100;
    
    for iteration = 1:maxIterations
        
        fx = GetPolynomialValue(iterationValues(end), polynomialCoefficients);
        fPrimeCoefficients = DifferentiatePolynomial(polynomialCoefficients, 1);
        fPrime = GetPolynomialValue(iterationValues(end), fPrimeCoefficients);
        
        fDoublePrimeCoefficients = DifferentiatePolynomial(polynomialCoefficients, 2);
        fDoublePrime = GetPolynomialValue(iterationValues(end), fDoublePrimeCoefficients);
        
        if fDoublePrime == 0
            break;
        end
        
        xNext = StepNewtonRaphson(iterationValues(end), fPrime, fDoublePrime);
        
        if abs(xNext - iterationValues(end)) < tolerance
            break;
        end
        
        iterationValues = [iterationValues, xNext];
    end
    
    iterationValues(isnan(iterationValues)) = [];
end


% This function should return the value of the polynomial f(x) = a0x^0 + a1x^1 + a2x^2 ...
% where a0, a1, ... are obtained from polynomialCoefficients.


function value = GetPolynomialValue(x, polynomialCoefficients)
    value = zeros(size(x));
    degree = length(polynomialCoefficients) - 1;
 
    for i = 1:length(polynomialCoefficients)
        value = value + polynomialCoefficients(i) * x.^(degree - (i - 1));
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
        degree = length(derivativeCoefficients) - 1;
        
        if degree == 0
            derivativeCoefficients = 0;
            return;
        end
        
        newCoefficients = zeros(1, degree);  
        for i = 1:degree
            newCoefficients(i) = derivativeCoefficients(i) * (degree - (i - 1));
        end
        
        derivativeCoefficients = newCoefficients;
    end
end
    

    % This method should perform a single step of the Newton-Raphson method.
% Note: In cases where the step cannot be completed, e.g. if f" = 0, a
% clear error message should be given.
function xNext = StepNewtonRaphson(x, fPrime, fDoublePrime)
 
    if fDoublePrime == 0
        error("Second derivative is zero. Newton-Raphson method cannot continue.");
    end
    
    xNext = x - fPrime / fDoublePrime;
    
end


% This method should plot the polynomial and the iterates obtained
% using NewtonRaphsonStep (if any iterates were generated).

 function PlotIterations(polynomialCoefficients, iterationValues)
    
    x = linspace(min(iterationValues) - 0.1, max(iterationValues) + 0.1, 1000);
    y = GetPolynomialValue(x, polynomialCoefficients);
    
    plot(x, y, 'b-', 'LineWidth', 2);
    hold on;
    
    yIterationValues = GetPolynomialValue(iterationValues, polynomialCoefficients);
    plot(iterationValues, yIterationValues, 'ro', 'MarkerSize', 8, 'LineWidth', 2); 
    
    xlabel('x');
    ylabel('f(x)');
    title('Newton-Raphson Iterations');
    
    grid on;
    
    yline(0, 'k--', 'LineWidth', 1);
    
    legend('Polynomial Curve', 'Iteration Points');
    
    xlim([min(x), max(x)]);
    ylim([min(y) - 1, max(y) + 1]); 
    
    hold off;
end

