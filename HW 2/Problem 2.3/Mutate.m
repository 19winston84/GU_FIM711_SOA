function mutatedChromosome = Mutate(chromosome,mutationProbability)

    nGenes = size(chromosome,2);
    mutatedChromosome = chromosome;
    for j = 1:nGenes
        r = rand;
        if (r<mutationProbability)
            newGene = rand;
            mutatedChromosome(j) = newGene;
        end
    end

end