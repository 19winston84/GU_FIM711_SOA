% First compute the function value, then compute the fitness
% value; see also the problem formulation.

function fitness = EvaluateIndividual(x)
    
    objectiveFunctionTerm1 = (1.5-x(1)+x(1)*x(2))^2;
    objectiveFunctionTerm2 = (2.25-x(1)+x(1)*x(2)^2)^2;
    objectiveFunctionTerm3 = (2.625-x(1)+x(1)*x(2)^3)^2;

    gValue = objectiveFunctionTerm1 + objectiveFunctionTerm2 + objectiveFunctionTerm3;

    fitness = 1/(gValue + 1);

end

