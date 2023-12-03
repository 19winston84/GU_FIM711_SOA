% RunLGP
clear all;
clc;

data = LoadFunctionData();
numberOfDataPoints = size(data,1);
data1 = data(:,1);
yValueData = data(:,2);

%% Variables
staticFitnessVariable = 25;
breakParameterStatic = 0;
numberOfGenerations = 3000;

minInitialChromosomeLength = 40;
maxInitialChromosomeLength = 64;
cMax = 10^18;
mMax = 400;

populationSize = 100;
crossoverProbability = 0.8;
mutationProbability = 0.4;
tournamentProbability = 0.7;
tournamentSize = 5;
constantsRange = -10:10;
numberOfConstants = 8;
numberOfVariables = 4;
lengthOfInstruction = 4;


constantRegisters = [-20,-5,-1,0,1,5,10,15];
variableRegisters = 1:numberOfVariables;

population = InitializePopulation(populationSize,minInitialChromosomeLength,maxInitialChromosomeLength,numberOfVariables,numberOfConstants);

%% Values to store
bestChromosomes = cell(1,1000);
fitnessBestList = [];
eRMSBestList = [];
bestERMS = inf;
iGeneration = 0;

tic
%for iGeneration = 1:numberOfGenerations
while bestERMS > 0.1
    mutationProbability = mutationProbability*0.9999;
    if mutationProbability < 0.021
        mutationProbability = 0.02;
    end 
    iGeneration = iGeneration + 1;
   
    fitnessList = zeros(populationSize,1);
    maximumFitness = 0.0;
    breakParameterStatic = 0;

    for iPop = 1:populationSize
        chromosome = population{iPop};
        chromosomeLength = length(chromosome);
        
        % if chromosomeLength > 400
        %     chromosome = chromosome(1:400);
        % end
        
        % argument = (chromosomeLength/mMax);
        % penaltyFactor = exp(0.01*argument);
        
        
        yValueChrom = zeros(numberOfDataPoints,1);
        
        for iDataPoints = 1:numberOfDataPoints
            yValueChrom(iDataPoints) = decodeChromosome(chromosome,numberOfVariables,constantRegisters,cMax,data1(iDataPoints));
        end
        
        eRMS = sqrt(mean((yValueChrom - yValueData).^2));

        if chromosomeLength > mMax
            eRMS = eRMS+2;
        end

        fitness = 1/eRMS;
        
        fitnessList(iPop) = fitness;
    
        if (fitness>maximumFitness)
            maximumFitness = fitness;
            bestIndividualIndex = iPop;
            bestChromosomes{iGeneration} = chromosome;
            bestERMS = eRMS;
        end
        
    end % Loop populationSize

    fitnessBestList(end+1) = maximumFitness;
    eRMSBestList(end+1) = bestERMS;

    tempChromosomes = population;

    for i = 1:2:populationSize
        i1 = TournamentSelect(fitnessList,tournamentProbability,tournamentSize);
        i2 = TournamentSelect(fitnessList,tournamentProbability,tournamentSize);
        chromosome1 = population{i1};
        chromosome2 = population{i2};
    
        
        r = rand;
        if (r<crossoverProbability)
            [newIndividual1, newIndividual2] = TwoPointCrossover(chromosome1, chromosome2, lengthOfInstruction);
            tempChromosomes{i} = newIndividual1;
            tempChromosomes{i+1} = newIndividual2;
        else
            tempChromosomes{i} = chromosome1;
            tempChromosomes{i+1} = chromosome2;
        end
    end % TS and Cross, loop over population

    for i = 1:populationSize
        originalChromosome = tempChromosomes{i};
        mutatedChromosome = Mutate(originalChromosome,mutationProbability,numberOfVariables,numberOfConstants);
        tempChromosomes{i} = mutatedChromosome;
    end 

    tempChromosomes{1} = population{bestIndividualIndex};
    population = tempChromosomes;
    
    % breakParameterStatic = 0;
    % staticIndex = iGeneration - staticFitnessVariable;
    % if staticFitnessVariable < iGeneration
    %     for i=1:staticFitnessVariable
    %         if fitnessBestList(staticIndex) == fitnessBestList(staticIndex + i)
    %             breakParameterStatic = breakParameterStatic + 1;
    %         end
    %     end
    % end
    % 
    % if breakParameterStatic > staticFitnessVariable-1
    %     mutationProbability = 0.25;
    %     numGenerationsWithMutation = 1;
    % end
    % 
    % if exist('numGenerationsWithMutation', 'var') && numGenerationsWithMutation > 0
    %     mutationProbability = 0.25;
    %     numGenerationsWithMutation = numGenerationsWithMutation - 1;
    % else
    %     % Reset mutationProbability to its original value (if needed)
    %     mutationProbability = 0.02; % You need to define originalMutationProbability.
    % end
    % % if mod(iGeneration, 20) == 0
    % %     fprintf('Current generation %d \n',iGeneration);
    % %     fprintf('Erms = %d \n', bestERMS)
    % % end
    
    
end

  


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% Plotting nothing else
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

xGenerations = 1:iGeneration;

plot(xGenerations, eRMSBestList, 'b', 'LineWidth', 2);

% Customize plot labels and legend
title('Evolution of Erms');
xlabel('Generations');
ylabel('Erms');
%legend('Training fitness',  'Validation fitness');
grid on;


load handel
sound(y,Fs)