function [newIndividual1, newIndividual2] = TwoPointCrossover(individual1, individual2, lengthOfInstruction)
    
    lengthOfIndividual1 = length(individual1)/lengthOfInstruction;
    lengthOfIndividual2 = length(individual2)/lengthOfInstruction;

    if lengthOfIndividual1 == 1 || lengthOfIndividual2 == 1
        newIndividual1 = individual1;
        newIndividual2 = individual2;
    
    else
        % determine 4 random crossover points
        crossPoint11 = randi(lengthOfIndividual1);
        crossPoint12 = randi(lengthOfIndividual1);
        crossPoint21 = randi(lengthOfIndividual2);
        crossPoint22 = randi(lengthOfIndividual2);
    
        while (crossPoint11 == crossPoint12)
            crossPoint12 = randi(lengthOfIndividual1);
        end
        while (crossPoint21 == crossPoint22)
            crossPoint22 = randi(lengthOfIndividual2);
        end
    
        % resort the crossover points if second is smaller than first
        if(crossPoint11 > crossPoint12)
            tmp = crossPoint11;
            crossPoint11 = crossPoint12;
            crossPoint12 = tmp;
        end
        if(crossPoint21 > crossPoint22)
            tmp = crossPoint21;
            crossPoint21 = crossPoint22;
            crossPoint22 = tmp;
        end
    
        % multiply crossover points with number of genes
        crossPoint11 = crossPoint11 * lengthOfInstruction;
        crossPoint12 = crossPoint12 * lengthOfInstruction;
        crossPoint21 = crossPoint21 * lengthOfInstruction;
        crossPoint22 = crossPoint22 * lengthOfInstruction;
    
        % cut the sections of the genes
        ind11 = individual1(1:crossPoint11);
        ind12 = individual1(crossPoint11+1:crossPoint12);
        ind13 = individual1(crossPoint12+1:end);
        
        ind21 = individual2(1:crossPoint21);
        ind22 = individual2(crossPoint21+1:crossPoint22);
        ind23 = individual2(crossPoint22+1:end);
        
        newIndividual1 = [ind11 ind22 ind13];
        newIndividual2 = [ind21 ind12 ind23];

    end
end

    

