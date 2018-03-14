

function POI = FindPointsOfInterest(circularEdgeLinkedList, env)
    
    
    [height, length] = size(circularEdgeLinkedList.node);
       
    
    freeSpaceCounter = 0;
    obstacleBoundaryCounter = 0;
    obstacleCounter = 0;
    
    POIcount = 0;
    for i = 1:length
        
        % get coordinates and array index for current edge node
        coordinate = ValToPosition(circularEdgeLinkedList.node(i).nodeNum, env);
        arrIndex = CoordToArray(coordinate, env);
        
        % pass over obstacles
        if(env.map(arrIndex(1),arrIndex(2)) == 2)
            
            obstacleCounter = obstacleCounter + 1;
            
            if(freeSpaceCounter ~= 0)
                error('Error: Transition from free space to obstacle without boundary in between')
            end

        elseif(env.map(arrIndex(1),arrIndex(2)) == 1)
            
            obstacleBoundaryCounter = obstacleBoundaryCounter + 1;
            
            % POI - transition from obstacle boundary to free space
            if(freeSpaceCounter  ~= 0)
                freeSpaceCounter = 0;
                POIcount = POIcount + 1;
                POI(POIcount) = circularEdgeLinkedList.node(i).nodeNum;
            end
            
            
        elseif(env.map(arrIndex(1),arrIndex(2)) == 0)
            
            freeSpaceCounter = freeSpaceCounter + 1;
            
            if(freeSpaceCounter > (env.numEdgeNodes/4))
                fprintf('need to make POI');
            end
            
            % POI - transition from obstacle boundary to free space
            if(obstacleBoundaryCounter  ~= 0)
                obstacleBoundaryCounter = 0;
                POIcount = POIcount + 1;
                POI(POIcount) = circularEdgeLinkedList.node(i).prevNode;
            end

        else
            error('Error: Invalid node value %d at (%d,%d)', circularEdgeLinkedList.node(i).nodeNum, coordinate(1), coordinate(2));
        end
        
        
        

        
        %if(obstacleBoundaryCounter
        
        
        %fprintf('checking node: %d\n',circularEdgeLinkedList.node(i).nodeNum);
        
        %fprintf('next node: %d\n',circularEdgeLinkedList.node(i).nextNode);
        %fprintf('prev node: %d\n',circularEdgeLinkedList.node(i).prevNode);
        
        
    end
    


end