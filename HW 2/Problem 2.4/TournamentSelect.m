function selectedIndividualIndex = TournamentSelect(fitnessList, tournamentProbability, tournamentSize)
    
    populationSize = size(fitnessList,1);
    indexAndFitnessOfSelectedRivals = zeros(2,tournamentSize); % fitness in first row, index in second
    
    for i=1:tournamentSize
        indexAndFitnessOfSelectedRivals(2,i) = 1 + fix(rand*populationSize);
        indexAndFitnessOfSelectedRivals(1,i) = fitnessList(indexAndFitnessOfSelectedRivals(2,i));

    end
    
    orderedFitnessList = sortrows(indexAndFitnessOfSelectedRivals', -1)';
    
    for i=1:tournamentSize
        r = rand;
        if i==tournamentSize
            selectedIndividualIndex=orderedFitnessList(2,i);
        else
            if (r < tournamentProbability)
                selectedIndividualIndex=orderedFitnessList(2,i);
                break
            end
        end
    end

end