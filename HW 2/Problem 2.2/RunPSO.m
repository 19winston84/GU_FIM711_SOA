%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% An Particle Swarm Optimisation (PSO) for finding optimas.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;
clf;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Objective funciton
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%f(x1,x2) = (x1^2+x2-11)^2 + (x1+x2^2-7)^2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numberOfIterations = 10;
numberOfParticles = 20;  %% Changes allowed [N=20-40]
nDimensions = 2;    %% Changes allowed
ranges = 5;         %% Do not change
alpha = 1.0;        %% Changes allowed [set it to 1]
beta = 0.99;       %% Changes allowed [choose between (0,1)]
inertiaWeight = 1.4;            %% Changes allowed [set it to 1.4]
minInertiaWeight = 0.3;
c1 = 2.0;           %% Changes allowed [set it to 2.0]
c2 = 2.0;           %% Changes allowed [set it to 2.0]
constantForPlot = 0.01;   %% Changes allowed
vMax = 5;           %% Changes allowed

optimas = zeros(numberOfIterations,3);
for k=1:numberOfIterations
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Initialization
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    coordinatesSwarmBestEver = zeros(1,nDimensions);
    swarmBestEver = 10000;
    oldSwarmBestEver = inf;
    
    coordinatesParticleBests = zeros(numberOfParticles,nDimensions);
    functionValueParticleBests = ones(numberOfParticles,1).*inf;
    
    velocities = InitialiseVelocities(ranges,numberOfParticles,nDimensions);
    positions = InitialisePositions(ranges,numberOfParticles,nDimensions);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Main loop
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    iIteration = 0;
    
   
    for i=1:1000000
     oldSwarmBestEver = swarmBestEver;
     iIteration = iIteration + 1;
    
     results = EvaluateSwarm(positions);
    
      % Updating the particle best for each particle if necessary.
     [newCoordinatesParticleBests,newFunctionValueParticleBests] = EvaluateParticleBest(positions,results,coordinatesParticleBests,functionValueParticleBests);
     coordinatesParticleBests = newCoordinatesParticleBests;
     functionValueParticleBests = newFunctionValueParticleBests;
    
     % Updating the swarm best ever particle if necessary.
     [swarmBest, coordinatesSwarmBest] = EvaluateSwarmBest(coordinatesParticleBests,functionValueParticleBests);
    
     if (swarmBest < swarmBestEver)
        swarmBestEver = swarmBest;
        coordinatesSwarmBestEver = coordinatesSwarmBest;
        
    
     end
    
     updatedVelocities = UpdateVelocities(vMax,inertiaWeight,velocities,c1,c2,coordinatesParticleBests,coordinatesSwarmBestEver,positions);
     velocities = updatedVelocities;
    
     updatedPositions = UpdatePositions(positions,velocities);
     positions = updatedPositions;
    
    
    
     if inertiaWeight > minInertiaWeight
        inertiaWeight = beta*inertiaWeight;
    
      
     end
     
   
    end
    
    disp(sprintf('(x1,x2) = (%.9f, %.9f) f(x1,x2) = %.5f', coordinatesSwarmBest(1), coordinatesSwarmBest(2), swarmBest));
    optimas(k,1) = coordinatesSwarmBest(1);
    optimas(k,2) = coordinatesSwarmBest(2);
    optimas(k,3) = swarmBest;

end

[unique_rows, ~, idx] = unique(optimas, 'rows');
fiewOptimas = unique_rows;




