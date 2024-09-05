% Here, the polynomial 10 - 2x - x^2 + x^3 is defined.

polynomialCoefficients = [10 -2 -1 1];
startingPoint = 2;
tolerance = 0.0001;
iterationValues = RunNewtonRaphson(polynomialCoefficients, startingPoint, tolerance);
PlotIterations(polynomialCoefficients,iterationValues);

% This function should run the Newton-Raphson method, making use of the
% other relevant functions (StepNewtonRaphson, DifferentiatePolynomial, and
% GetPolynomialValue). Before returning iterationValues any non-plottable values 
% (e.g. NaN) that can occur if the method fails (e.g. if the input is a
% first-order polynomial) should be removed, so that only values that
% CAN be plotted are returned. Thus, in some cases (again, the case of
% a first-order polynomial is an example) there may be no points to plot.

function iterationValues = RunNewtonRaphson(polynomialCoefficients, startingPoint, tolerance)
 
    iterationValues = [startingPoint];
    
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

value = polyval(polynomialCoefficients , x);

end

% This method should return the coefficients of the k-th derivative (defined by
% the derivativeOrder) of the polynomial given by the polynomialCoefficients (see also GetPolynomialValue)

function derivativeCoefficients = DifferentiatePolynomial(polynomialCoefficients, derivativeOrder)
   
    derivativeCoefficients = polynomialCoefficients;
    
    if derivativeOrder < 0
        error('Derivative order must be non-negative.');
    end
    
    for k = 1:derivativeOrder
        derivativeCoefficients = polyder(derivativeCoefficients);
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
