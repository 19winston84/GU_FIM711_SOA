% This function should return the value of the polynomial f(x) = a0x^0 + a1x^1 + a2x^2 ...
% where a0, a1, ... are obtained from polynomialCoefficients.

function value = GetPolynomialValue(x, polynomialCoefficients)
    
    value = [];
    exponents = 0:(length(polynomialCoefficients)-1);
    for i = 1:length(x)
        vectorX = x(i).*ones(1,length(exponents));
        vectorMonomial = vectorX.^exponents;
        value(end+1) = dot(polynomialCoefficients,vectorMonomial);
    end
end
        
