function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)

    numberOfCityLocations = size(visibility,1);
    tabuList = zeros(1,numberOfCityLocations);
    path = zeros(1,numberOfCityLocations);
    
    for i = 1:numberOfCityLocations
        
        nextNode = GetNode(tabuList, pheromoneLevel, visibility, alpha, beta);
        tabuList(i) = nextNode;
        path(i) = nextNode;
        
   
    end
    
end