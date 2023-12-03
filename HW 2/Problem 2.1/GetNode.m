function nextNode = GetNode(tabuList,pheromoneLevel,visibility,alpha,beta)
    
    numberOfCityLocations = size(visibility,1);
    locationList = 1:numberOfCityLocations;


    if all(tabuList == 0)
        nextNode = randi(numberOfCityLocations);
        
    else

        locationOptions = setdiff(locationList, tabuList);
        lastNonZeroIndex = find(tabuList, 1, 'last');
       
        previousNode = tabuList(lastNonZeroIndex);
        

        
        
        % calculate denominator for next candidates
        denominatorList = zeros(1,length(locationOptions));
        for i = 1:length(locationOptions)
            indexCandidateNode = locationOptions(i);

            factor1 = pheromoneLevel(previousNode,indexCandidateNode).^alpha;
            factor2 = visibility(previousNode,indexCandidateNode).^beta;

            summand = factor1 * factor2;

            denominatorList(i) = summand;% here there might be problems with the indexes.
            
        end
        denominator = sum(denominatorList);
        
        
        % nextnodeCandidates(1,:)=probability
        % nextnodeCandidates(2,:)=indexes 
        % nextnodeCandidates(2,:)=rouletteWheelPiece 
        nextNodeCandidates = zeros(size(3,length(locationOptions)));
        for i = 1:length(locationOptions)
            
            indexCandidateNode = locationOptions(i);
            nextNodeCandidates(2,i) = indexCandidateNode;
            
            factor1 = pheromoneLevel(previousNode,indexCandidateNode).^alpha;
            factor2 = visibility(previousNode,indexCandidateNode).^beta;
            
            nominator = factor1 * factor2;
            probabilityCandidateNode = nominator/denominator;

            nextNodeCandidates(1,i) = probabilityCandidateNode;
        end
        
        % roulett-wheel selection
        
        for i = 1:length(locationOptions)
            
            roulettWheelPiece = sum(nextNodeCandidates(1,1:i));
            nextNodeCandidates(3,i) = roulettWheelPiece;
        
        end

        randomNumber = rand();
        
        for i = 1:length(locationOptions)
        
            if nextNodeCandidates(3,i)>randomNumber
                nextNode = nextNodeCandidates(2,i);
                break
           
            end
        
        end
       
    end

end