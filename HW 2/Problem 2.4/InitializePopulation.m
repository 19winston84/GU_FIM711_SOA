function population = InitializePopulation(populationSize,minChromosomeLength,maxChromosomeLength,numberOfVariables,numberOfConstants);

population = cell(1,populationSize);
numberOfUnion = numberOfVariables+numberOfConstants;
for i = 1:populationSize
 chromosomeLength = minChromosomeLength + 4*fix(rand*(maxChromosomeLength-minChromosomeLength));
 %chromosomeLength = minChromosomeLength;
 tmpChromosome = zeros(1,chromosomeLength);
 
 for iGene = 1:chromosomeLength
    if mod(iGene,4) == 1
        tmpChromosome(iGene) = randi(4);
    end
    if mod(iGene,4) == 2
        tmpChromosome(iGene) = randi(numberOfVariables);
    end
    if mod(iGene,4) == 3
        tmpChromosome(iGene) = randi(numberOfUnion);
    end
    if mod(iGene,4) == 0
        tmpChromosome(iGene) = randi(numberOfUnion);
    end
 end
 
 % Set the third value to 1
 tmpChromosome(3) = 1;
 
 
 population{i} = tmpChromosome;
end