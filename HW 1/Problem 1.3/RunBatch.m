%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter specifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear workspace
clc

numberOfRuns = 100;                % Do NOT change
populationSize = 100;              % Do NOT change
maximumVariableValue = 5;          % Do NOT change (x_i in [-a,a], where a = maximumVariableValue)
numberOfGenes = 50;                % Do NOT change
numberOfVariables = 2;		   % Do NOT change
numberOfGenerations = 300;         % Do NOT change
tournamentSize = 2;                % Do NOT change
tournamentProbability = 0.75;      % Do NOT change
crossoverProbability = 0.8;        % Do NOT change


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Batch runs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define more runs here (pMut < 0.02) ...

differentMutationProbabilities = [0, 0.01, 0.02, 0.03, 0.04, 0.06, 0.08, 0.1, 0.6, 0.7, 0.8, 0.9, 0.99];
amountOfProbabilities = length(differentMutationProbabilities);
medianDependingOnPMut = zeros(1,amountOfProbabilities);

for k=1:amountOfProbabilities

    mutationProbability = differentMutationProbabilities(k);
    sprintf('Mutation rate = %0.5f', mutationProbability)
    maximumFitnessList002 = zeros(numberOfRuns,1);
    
    for i = 1:numberOfRuns 

     [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                           tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
     %sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
     maximumFitnessList002(i,1) = maximumFitness;

    end
    
    average002 = mean(maximumFitnessList002);
    median002 = median(maximumFitnessList002);
    std002 = sqrt(var(maximumFitnessList002));
    sprintf('PMut = %0.2f : Median: %0.10f, Average: %0.10f, STD: %0.10f', mutationProbability, median002, average002, std002)
    
    medianDependingOnPMut(k) = median002;

end



% ... and here (pMut > 0.02)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Summary of results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add more results summaries here (pMut < 0.02) ...



% ... and here (pMut > 0.02)

