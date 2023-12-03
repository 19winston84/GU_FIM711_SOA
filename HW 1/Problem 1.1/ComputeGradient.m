% This function should return the gradient of f_p = f + penalty.
% You may hard-code the gradient required for this specific problem.

function gradF = ComputeGradient(x,mu)

    fPrime1 = 2*(x(1)-1);
    fPrime2 = 4*(x(2)-2);

    penaltyPrime1 = 4*mu*x(1)*(x(1)^2+x(2)^2-1);
    penaltyPrime2 = 4*mu*x(2)*(x(1)^2+x(2)^2-1);

    f_pPrime1 = fPrime1+penaltyPrime1;
    f_pPrime2 = fPrime2+penaltyPrime2;

    gradF = [f_pPrime1, f_pPrime2];

end
