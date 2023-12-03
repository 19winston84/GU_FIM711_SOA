function [coordinatesParticleBests,functionValueParticleBests] = EvaluateParticleBest(positions,results,coordinatesParticleBests,functionValueParticleBests)

    updateIndices = functionValueParticleBests > results;

    coordinatesParticleBests(updateIndices, :) = positions(updateIndices, :);

    functionValueParticleBests(updateIndices) = results(updateIndices);



end
