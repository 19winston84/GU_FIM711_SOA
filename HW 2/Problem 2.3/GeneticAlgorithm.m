function chromosomes = GeneticAlgorithm(chromosomes,populationSize,fitness,crossoverProbability,tournamentSelectionParameter,mutationProbability,creepMutationProbability,creepRate,bestIndividualIndex)
        
        tempChromosomes = chromosomes;

        for i = 1:2:populationSize
            i1 = TournamentSelect(fitness,tournamentSelectionParameter);
            i2 = TournamentSelect(fitness,tournamentSelectionParameter);
            chromosome1 = chromosomes(i1,:);
            chromosome2 = chromosomes(i2,:);
        
            r = rand;
            if (r<crossoverProbability)
                newChromosomePair = Cross(chromosome1,chromosome2);
                tempChromosomes(i,:) = newChromosomePair(1,:);
                tempChromosomes(i+1,:) = newChromosomePair(2,:);
            else
                tempChromosomes(i,:) = chromosome1;
                tempChromosomes(i+1,:) = chromosome2;
            end
        end % TS and Cross, loop over population
        
        
        for i = 1:populationSize
            originalChromosome = tempChromosomes(i,:);
            mutatedChromosome = Mutate(originalChromosome,mutationProbability);
            tempChromosomes(i,:) = mutatedChromosome;
        end 
    
        for i = 1:populationSize
            originalChromosome2 = tempChromosomes(i,:);
            mutatedChromosome2 = CreepMutate(originalChromosome2,creepMutationProbability,creepRate);
            tempChromosomes(i,:) = mutatedChromosome2;
        end 
        
        tempChromosomes(1,:) = chromosomes(bestIndividualIndex,:);
        chromosomes = tempChromosomes;