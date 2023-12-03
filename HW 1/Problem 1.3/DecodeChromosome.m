% Note: Each component of x should take values in [-a,a], where a = maximumVariableValue.

function x = DecodeChromosome(chromosome,numberOfVariables,maximumVariableValue)
    
    mLengthOfChromosome = length(chromosome); %this might not work. If not, change it back to old verison in SimpleEvolutionaryAlgorithm
    kDecodeBoundary = mLengthOfChromosome/numberOfVariables; %in case of error try meddeling with line 5

    x(1) = 0.0;
    for j = 1:kDecodeBoundary
        x(1) = x(1) + chromosome(j)*2^(-j);
    end
    x(1) = -maximumVariableValue + 2*maximumVariableValue*x(1)/(1-2^(-kDecodeBoundary));

    x(2) = 0.0;
    for j = 1:kDecodeBoundary
        x(2) = x(2) + chromosome(j+kDecodeBoundary)*2^(-j);
    end
    x(2) = -maximumVariableValue + 2*maximumVariableValue*x(2)/(1-2^(-kDecodeBoundary));

end
