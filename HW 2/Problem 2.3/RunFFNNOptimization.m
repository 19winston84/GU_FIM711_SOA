
clf;
clc;


% Note:  
% c of sigmoid. constant = 2; is set in FNN.m set once and for all
% wMax is chosen arbitrarily atm.

%% FFNN parameters

nIn = 3; % input parameters
nHidden = 7; % number of hidden neurons
nOut = 2; % number of output parameters
sigmoidConstant = 2; % see FNN.m

%% GA parameters

populationSize = 100;
chromosomeLength = (nHidden*(nIn+1)+(nHidden+1)*nOut);
crossoverProbability = 0.3;
mutationProbability = 1/chromosomeLength;
creepMutationProbability = 0.8;
creepRate = 0.005;
tournamentSelectionParameter = 0.75;

%% Driving parameters

wMax = 5.0; % the range for weights (-wMax, wMax)
vMax = 25; % [m/s]
vMin = 1; %[m/s]
alphaMax= 10; % [degrees]
lMax = 1000; % [m]
tMax = 750; %[Kelvin]
timeMax = 200; % [s]
tAmb = 283; %[Kelvin]
gravitation = 9.81; % [m/s^2]
truckMass = 20000; % [kg]
tau = 30; % [Nan.] see GetTemperature.m
cH = 40; % [Nan.] see GetTemperature.m
cB = 3000; % [Nan.] see TruckModel.m
deltaT = 0.02; % [s]
gearChangeThreshold = 2/deltaT; % see GearBox.m

%% Holdout validation parameters
overfittingVariable = 2000; 
staticValidationFitnessVariable = 2000;

%% Begin main loop

% Initialize chromosomes
chromosomes = rand(populationSize, (nHidden * (nIn + 1) + nOut * (nHidden + 1)));

% Initialize arrays to store matrices and chromosomes
arrayOfwIH = cell(1, populationSize);
arrayOfwHO = cell(1, populationSize);
bestChromosomes = zeros(10000,chromosomeLength);

valFitnessMeasureList = [];
trainFitnessBestList = [];
breakParameterOverfitting = 0;
breakParameterStatic = 0;
overfittingPlotBinary = 0;
staticPlotBinary = 0;
iGeneration = 0;


while breakParameterOverfitting < overfittingVariable ...
        && breakParameterStatic < staticValidationFitnessVariable
    tic
    iGeneration = iGeneration + 1;
    fprintf('Current generation = %d\n', iGeneration);
    
    maximumFitness = 0.0; 
    wIHBest = zeros(nHidden, nIn + 1);
    wHOBest = zeros(nOut, nHidden + 1);

    bestIndividualIndex = 0;
    
    
    for i = 1:populationSize

        fitness = zeros(populationSize,1);
        
        chromosome = chromosomes(i,:);
        [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax);
        
        listOfFitnessValue = zeros(1,10);
        
        for iSlope = 1:10
            
            %Initialize starting variables
            tB = 500; % [Kelvin]
            velocity = 20; % [m/s]
            gear = 7;
            xPosition = 0; %position
            %deltaTB = 317; % [Kelvin]
            totalDistance = 0;
            totalTime = 0;
            gearChangeTimeCounter = 0;

            while (xPosition <= lMax) && ...
                (tB <= tMax) && ...
                (velocity >= vMin) && ...
                (velocity <= vMax) && ...
                (totalTime <= timeMax)
                
                alpha = GetSlopeAngle(xPosition, iSlope, 1); 

                input = [velocity/vMax, alpha/alphaMax, tB/tMax];
                
                [pP, deltaGear] = FNN(input,wIH,wHO,sigmoidConstant);
                
                tB = GetTemperature(pP,tB,tAmb,tau,cH);
                
                velocity = TruckModel(alpha,gravitation,tB,pP,tMax,gear,cB,truckMass,deltaT,velocity);
                
                xPosition = xPosition + velocity * deltaT * cos(alpha*pi/180);

                [gear, gearChangeTimeCounter] = GearBox(deltaGear,gear,gearChangeTimeCounter,gearChangeThreshold);
                
                totalDistance = xPosition;

                totalTime = totalTime + deltaT;
    
            end % while run

            averageVelocity = totalDistance / totalTime;
            listOfFitnessValue(iSlope) = averageVelocity * totalDistance;

        end % for Loop

        averageFitness = mean(listOfFitnessValue);

        fitness(i) = averageFitness;
    
            if (fitness(i)>maximumFitness)
                maximumFitness = fitness(i);
                bestIndividualIndex = i;
                wIHBest = wIH;
                wHOBest = wHO;
                bestChromosomes(iGeneration,:) = EncodeNetwork(wIHBest,wHOBest,wMax);
            end
    
    end % Loop over pop
    
    trainFitnessBestList(end+1)= maximumFitness;

    chromosomes = GeneticAlgorithm(chromosomes,populationSize,fitness,...
        crossoverProbability,tournamentSelectionParameter,...
        mutationProbability,creepMutationProbability,creepRate,...
        bestIndividualIndex);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    % Here the validation starts
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

    arrayOfSlopeAngleList = cell(1, 5);
    arrayOfPPList = cell(1, 5);
    arrayOfGearList = cell(1, 5);
    arrayOfVelocityList = cell(1, 5);
    arrayOfTBList = cell(1, 5);
    
    [wIH,wHO] = DecodeChromosome(chromosomes(1,:),nIn,nHidden,nOut,wMax);
    
    listOfFitnessValues = zeros(1,5);

    for iSlope=1:5
    
        % Initialising starting variables
        tB = 500; % [Kelvin]
        velocity = 20; % [m/s]
        gear = 7;
        xPosition = 0; % [m]
        
        totalDistance = 0;
        totalTime = 0;
        gearChangeTimeCounter = 0;

        while (xPosition <= lMax) && ...
            (tB <= tMax) && ...
            (velocity >= vMin) && ...
            (velocity <= vMax) && ...
            (totalTime <= timeMax)
            
            alpha = GetSlopeAngle(xPosition, iSlope, 2);
            
            input = [velocity/vMax, alpha/alphaMax, tB/tMax];
            
            [pP, deltaGear] = FNN(input,wIH,wHO,sigmoidConstant);
    
            tB = GetTemperature(pP,tB,tAmb,tau,cH);
        
            velocity = TruckModel(alpha,gravitation,tB,pP,tMax,gear,cB,truckMass,deltaT,velocity);
            
            xPosition = xPosition + velocity * deltaT * cos(alpha*pi/180);
        
            [gear, gearChangeTimeCounter] = GearBox(deltaGear,gear,gearChangeTimeCounter,gearChangeThreshold);

            totalDistance = xPosition;
            totalTime = totalTime + deltaT;
    
        end % while run

        averageVelocity = totalDistance / totalTime;

        listOfFitnessValues(iSlope) = averageVelocity * totalDistance; 
    
        valFitness = mean(listOfFitnessValues);
                
    end % for looop over iSlope

    valFitnessMeasureList(end+1)=valFitness;
    
    disp(valFitness);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    % Break conditions including setup to save right chromosome
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    breakParameterOverfitting = 0;
    breakParameterStatic = 0;

    oldestIndex = iGeneration - overfittingVariable;
    if overfittingVariable < iGeneration
        for i=1:overfittingVariable
            if valFitnessMeasureList(oldestIndex) > valFitnessMeasureList(oldestIndex+i)
                breakParameterOverfitting = breakParameterOverfitting + 1;
            end
        end
    end

    staticIndex = iGeneration - staticValidationFitnessVariable;
    if staticValidationFitnessVariable < iGeneration
        for i=1:staticValidationFitnessVariable
            if valFitnessMeasureList(staticIndex) == valFitnessMeasureList(staticIndex + i)
                breakParameterStatic = breakParameterStatic + 1;
            end
        end
    end

    if breakParameterOverfitting >= overfittingVariable
        fprintf('The validation fitness value only sunk over the last %d generations.\n', overfittingVariable);
        overfittingPlotBinary = overfittingPlotBinary + 1;
        
        % filename = 'BestChromosome.m';
        % fileID = fopen(filename, 'w');
        % fprintf(fileID, 'function chromosome = BestChromosome()\n');
        % fprintf(fileID, 'chromosome = [');
        % fprintf(fileID, '%d ', bestChromosomes(oldestIndex,:));
        % fprintf(fileID, '];\n');
        % fprintf(fileID, 'end');
        % fclose(fileID);

    elseif breakParameterStatic >= staticValidationFitnessVariable
        fprintf('The validation fitness value did not change over the last %d generations.\n', staticValidationFitnessVariable);
        staticPlotBinary = staticPlotBinary + 1;
        
        % filename = 'BestChromosome.m';
        % fileID = fopen(filename, 'w');
        % fprintf(fileID, 'function chromosome = BestChromosome()\n');
        % fprintf(fileID, 'chromosome = [');
        % fprintf(fileID, '%d ', bestChromosomes(staticIndex,:));
        % fprintf(fileID, '];\n');
        % fprintf(fileID, 'end');
        % fclose(fileID);

    end
toc
end % whole process


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% Plotting nothing else
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

xGenerations = 1:iGeneration;

hold on;

plot(xGenerations, trainFitnessBestList, 'b', 'LineWidth', 2);
plot(xGenerations, valFitnessMeasureList, 'r', 'LineWidth', 2);

if staticPlotBinary > 0
    xvalue = staticIndex;
else
    xvalue = oldestIndex;
end

% Create a vertical dashed line
plot([xvalue, xvalue], ylim, '--k', 'LineWidth', 1);


% Customize plot labels and legend
title('Training Fitness vs. Validation Fitness');
xlabel('Generations');
ylabel('Fitness');
legend('Training fitness',  'Validation fitness');
grid on;

load handel
sound(y,Fs)