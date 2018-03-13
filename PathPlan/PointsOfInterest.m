% points = PointsOfInterest(env)

function points = PointsOfInterest(env)

    [envHeight, envLength] = size(env.map);
    
    edgeNodeCount = 0;
    
    for y = 1:envHeight
        for x = 1:envLength
    
            arrIndex = CoordToArray([x,y],env);
            i = arrIndex(1);
            j = arrIndex(2);
            
            nodeNum = PositionToVal([x,y],env);
            
            % create a list of edge nodes
            if(env.node(i,j).edge == 1)
                
                % error checking to ensure edge nodes have been discovered
                if(env.node(i,j).discovered == 0)
                    error('Node %d cannot be undiscovered and an edge',nodeNum)
                end
                
                % increment number of edge nodes and add node to list
                edgeNodeCount = edgeNodeCount + 1; 
                edgeNodes(edgeNodeCount) = nodeNum;
                
            end
        end
    end
    
    
    % 1. find edge node
    % 2. find adjacent edges
    % 3. travel vertical or horizontal if possible
    % 4. store in 
    
    prevNode = 0;
    for i = 1:edgeNodeCount
        
        edgeCircle.node(i).prevNode = prevNode;    % 0 for first node
        % use first node in edge node list
        if(i == 1)
            edgeCircle.node(i).nodeNum = edgeNodes(1);
            
        % use next node
        else
            edgeCircle.node(i).nodeNum = nextNode;
        end
        
        
        % coordinate of current edge node
        coordinate = ValToPosition(edgeCircle.node(i).nodeNum,env);
        
        adjEdgeCount = 0;
        % check surrounding nodes
        for x = -1:1
            for y = -1:1
                
                % skip same node
                if(x == 0 && y == 0)
                    continue
                end
                
                % check if coord is valid
                if(IsCoordValid([coordinate(1)+x,coordinate(2)+y],env))
                    arrIndex = CoordToArray([coordinate(1)+x,coordinate(2)+y],env);
                    
                    % check if adjacent node is an edge
                    if(env.node(arrIndex(1),arrIndex(2)).edge == 1)
                        fprintf('found adjacent edge\n');
                        adjEdgeCount = adjEdgeCount + 1;
                        
                        nextEdge(adjEdgeCount) = PositionToVal([coordinate(1)+x,coordinate(2)+y],env);
                    end
                end    
            end
        end
        
        
        %
        % logic to chose horizontal or vertical edge
        %
        
        % grab vertical or horizontal if possible
        nextNode = nextEdge(1);
        
        % store last node
        prevNode = edgeCircle.node(i).nodeNum; 
    end
    

end