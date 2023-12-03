function mutatedChromosome = CreepMutate(chromosome,creepMutationProbability,creepRate)
    

    nGenes = size(chromosome,2);
    mutatedChromosome = chromosome;
    for j = 1:nGenes
        r = rand;
        if (r<creepMutationProbability)
            q = rand;
            newGene = mutatedChromosome(j)-creepRate/2+creepRate*q;
            if newGene < 0
                mutatedChromosome(j) = 0;
            elseif newGene > 1
                mutatedChromosome(j) = 1;
            else
                mutatedChromosome(j)=newGene;
            end
        end
    end



end 