function positions = InitialisePositions(ranges,numberOfParticles,nDimensions)

    xMax = ranges;
    xMin = -ranges;
    
    factor = (xMax - xMin);
    
    positions = xMin + rand(numberOfParticles, nDimensions) * factor;


end