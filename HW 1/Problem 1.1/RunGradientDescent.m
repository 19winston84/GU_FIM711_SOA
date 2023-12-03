% This function should run gradient descent until the L2 norm of the
% gradient falls below the specified threshold.

function x = RunGradientDescent(xStart, mu, eta, gradientTolerance)
    
    while norm(ComputeGradient(xStart,mu))>gradientTolerance
        
        xNext = xStart-eta*ComputeGradient(xStart,mu);
        xStart = xNext;
    
    end
    x = xStart;

end
    