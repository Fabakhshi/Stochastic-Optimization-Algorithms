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
 