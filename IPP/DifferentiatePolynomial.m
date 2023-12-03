% This method should return the coefficients of the k-th derivative (defined by
% the derivativeOrder) of the polynomial given by the polynomialCoefficients (see also GetPolynomialValue)

function derivativCoefficients = DifferentiatePolynomial(polynomialCoefficients, derivativeOrder)
    
    derivativCoefficients = polynomialCoefficients;
    for i = 1:derivativeOrder
        exponents = 0:(length(derivativCoefficients)-1);
        derivativCoefficients = derivativCoefficients.*exponents; 
        derivativCoefficients = derivativCoefficients(2:end);
    end
end 

