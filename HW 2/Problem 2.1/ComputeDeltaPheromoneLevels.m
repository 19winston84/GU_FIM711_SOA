function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)
    

    nDimension = size(pathCollection, 2);
    nAnts = size(pathCollection,1);
    deltaPheromoneLevel = zeros(nDimension);
    
    for k = 1:nAnts
        pathK = pathCollection(k,:);
        for i = 1:nDimension
           if i < nDimension
               tmpIndex1 = pathK(i);
               tmpIndex2 = pathK(i+1);
               update = deltaPheromoneLevel(tmpIndex1,tmpIndex2) + 1/pathLengthCollection(k);
               deltaPheromoneLevel(tmpIndex1,tmpIndex2) = update;
           else
               tmpIndex1 = pathK(i);
               update = deltaPheromoneLevel(tmpIndex1,pathK(1)) + 1/pathLengthCollection(k);
               deltaPheromoneLevel(tmpIndex1,pathK(1)) = update;
           end
        end
    
    end


end