function [swarmBest,coordinatesSwarmBest] = EvaluateSwarmBest(positions,results)

    [minValue, minIndex] = min(results);

    swarmBest = minValue;

    x1ForMinValue = positions(minIndex,1);
    x2ForMinValue = positions(minIndex,2);

    coordinatesSwarmBest = [x1ForMinValue, x2ForMinValue];


end