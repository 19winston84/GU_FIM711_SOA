function newVelocities = UpdateVelocities(vMax,inertiaWeight,velocities,c1,c2,coordinatesParticleBests,coordinatesSwarmBestEver,positions)

    numberOfParticles = size(velocities,1);
    
    coordinatesSwarmBestEver1 = zeros(numberOfParticles,2);
    for i = 1:numberOfParticles
        coordinatesSwarmBestEver1(i, :) = coordinatesSwarmBestEver;
    end
    

    summand1 = inertiaWeight.*velocities;
    summand2 = c1 * rand(numberOfParticles,1) .* (coordinatesParticleBests-positions);
    summand3 = c2 * rand(numberOfParticles,1) .* (coordinatesSwarmBestEver1-positions);

    newVelocities = summand1+summand2+summand3;

    newVelocities(newVelocities > vMax) = vMax;
    newVelocities(newVelocities < -vMax) = -vMax;

end

