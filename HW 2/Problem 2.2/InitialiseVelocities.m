function velocities = InitialiseVelocities(ranges,numberOfParticles,nDimensions)

    xMax = ranges;
    xMin = -ranges;
    
    factor = (xMax - xMin);
    summand = -(xMax-xMin)/2;
    
    velocities = summand + rand(numberOfParticles, nDimensions) * factor ;


end