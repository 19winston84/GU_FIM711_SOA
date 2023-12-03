clf;

%% FNN parameters

nIn = 3; % input parameters
nHidden = 7; % number of hidden neurons
nOut = 2; % number of output parameters
sigmoidConstant = 2; % see FNN.m

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
deltaT = 0.01; % [s]
gearChangeThreshold = 2/deltaT; % see GearBox.m


arrayOfSlopeAngleList = cell(1, 5);
arrayOfPPList = cell(1, 5);
arrayOfGearList = cell(1, 5);
arrayOfVelocityList = cell(1, 5);
arrayOfTBList = cell(1, 5);


chromosome = BestChromosome();
[wIH,wHO] = DecodeChromosome(chromosome,nIn,nHidden,nOut,wMax);

listOfFitnessValue = zeros(1,5);


for iSlope=1:5

    % Initialize starting variables
    tB = 500; % [Kelvin]
    velocity = 20; % [m/s]
    gear = 7;
    xPosition = 0; %position
    
    totalDistance = 0;
    totalTime = 0;
    slopeAngleList = [];
    pPList = [];
    gearList = [];
    velocityList = [];
    tBList = [];
    xPositonList = [];
    gearChangeTimeCounter = 0;

    while (xPosition <= lMax) && ...
        (tB <= tMax) && ...
        (velocity >= vMin) && ...
        (velocity <= vMax) && ...
        (totalTime <= timeMax)
        
        xPositonList(end+1) = totalDistance;
        tBList(end+1) = tB;
        velocityList(end+1) = velocity;
        gearList(end+1) = gear;
        
        alpha = GetSlopeAngle(xPosition, iSlope, 3);
            
        input = [velocity/vMax, alpha/alphaMax, tB/tMax];
            
        [pP, deltaGear] = FNN(input,wIH,wHO,sigmoidConstant);

        pPList(end+1) = pP;
    
        slopeAngleList(end+1) = alpha;
        
        tB = GetTemperature(pP,tB,tAmb,tau,cH);
        
        velocity = TruckModel(alpha,gravitation,tB,pP,tMax,gear,cB,truckMass,deltaT,velocity);
            
        xPosition = xPosition + velocity * deltaT * cos(alpha*pi/180);
        
        [gear, gearChangeTimeCounter] = GearBox(deltaGear,gear,gearChangeTimeCounter,gearChangeThreshold);
        
        totalDistance = xPosition;
        totalTime = totalTime + deltaT;

    end % while run

    averageVelocity = totalDistance / totalTime;
    
    arrayOfSlopeAngleList{iSlope} = slopeAngleList;
    arrayOfPPList{iSlope} = xPositonList;
    arrayOfGearList{iSlope} = tBList;
    arrayOfVelocityList{iSlope} = velocityList;
    arrayOfTBList{iSlope} = gearList;    
    
    listOfFitnessValue(iSlope) = averageVelocity * totalDistance; 

    valFitness = listOfFitnessValue(iSlope);

    fprintf('For iSlope = %d, the driven distance was %.2f and the fitness value was %.2f.\n', iSlope, totalDistance, valFitness);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    % Plotting nothing else
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

    figure;

    subplot(5, 1, 1);
    plot(xPositonList, slopeAngleList);
    xlabel('Distance');
    ylabel('Slope Angle');
    title(['Slope Angle vs. Distance for iSlope = ' num2str(iSlope)]);

    subplot(5, 1, 2);
    plot(xPositonList, pPList);
    xlabel('Distance');
    ylabel('Brake pedal pressure');
    title(['Brake pedal pressure vs. Distance for iSlope = ' num2str(iSlope)]);

    subplot(5, 1, 3);
    plot(xPositonList, gearList);
    xlabel('Distance');
    ylabel('Gear');
    title(['Gear vs. Distance for iSlope = ' num2str(iSlope)]);

    subplot(5, 1, 4);
    plot(xPositonList, velocityList);
    xlabel('Distance');
    ylabel('Velocity');
    title(['Velocity vs. Distance for iSlope = ' num2str(iSlope)]);

    subplot(5, 1, 5);
    plot(xPositonList, tBList);
    xlabel('Distance');
    ylabel('Brake temperature');
    title(['Brake temperature vs. Distance for iSlope = ' num2str(iSlope)]);

    sgtitle(['Various Parameters vs. Distance for iSlope = ' num2str(iSlope)]);

            
end %
        


