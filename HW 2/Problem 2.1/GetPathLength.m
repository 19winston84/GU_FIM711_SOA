function pathLength = GetPathLength(path,cityLocation);
    
    pathLength = 0;
    for i = 1:length(path)
       
        if i == length(path)
            indexHomeBase = path(1);
            indexPreviousCity = path(i);

            firstCity = cityLocation(indexHomeBase,:);
            lastCity = cityLocation(indexPreviousCity,:);

            newPathLength = pathLength + norm(firstCity-lastCity);

        else
            indexPreviousCity = path(i);
            indexNextCity = path(i+1);

            previousCity = cityLocation(indexPreviousCity,:);
            nextCity = cityLocation(indexNextCity,:);

            newPathLength = pathLength + norm(nextCity-previousCity);

        end
        pathLength = newPathLength;
    end
    

end
