function mutatedChromosome = Mutate(chromosome,mutationProbability,numberOfVariables,numberOfConstants)

    nGenes = size(chromosome,2);
    mutatedChromosome = chromosome;
    numberOfUnion = numberOfVariables+numberOfConstants;
    for iGene = 1:nGenes
        r = rand;
        if (r<mutationProbability)
            if mod(iGene,4) == 1
                mutatedChromosome(iGene) = randi(4);
            end
            if mod(iGene,4) == 2
                mutatedChromosome(iGene) = randi(numberOfVariables);
            end
            if mod(iGene,4) == 3
                mutatedChromosome(iGene) = randi(numberOfUnion);
            end
            if mod(iGene,4) == 0
                mutatedChromosome(iGene) = randi(numberOfUnion);
            end
        end
    end

end