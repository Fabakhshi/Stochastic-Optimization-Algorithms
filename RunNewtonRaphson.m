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
