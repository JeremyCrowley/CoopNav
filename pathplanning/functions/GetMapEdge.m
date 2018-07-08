% edgeCircle = GetMapEdge(env)
%
% creates a circular linked list of the nodes on the discovered edge of the
% map, used for the pattern based point of interest detectin algorithm

function edgeCircle = GetMapEdge(env)

    [envHeight, envLength] = size(env.map);
    
    % create list of edge nodes in map 
    edgeNodes = FindEdgeNodes(env);
    
    edgeNodeCount = length(edgeNodes);
    
    % 1. find edge node
    % 2. find adjacent edges
    % 3. travel vertical or horizontal if possible
    % 4. store in 
    
    prevNode = 0;
    lastMove = 0;
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
        %fprintf('Checking edge at (%d,%d)\n',coordinate(1),coordinate(2));
        
        
        % check surrounding nodes
        
        x = [-1 1 0 0];
        y = [0 0 -1 1];
        
        adjEdgeCount = 0;
        % check right up left down
        for j = 1:4
            
            if(IsCoordValid([coordinate(1)+x(j),coordinate(2)+y(j)],env))

                arrIndex = CoordToArray([coordinate(1)+x(j),coordinate(2)+y(j)],env);

                % check if adjacent node is an edge
                if(env.node(arrIndex(1),arrIndex(2)).edge == 1)
                    %fprintf('found adjacent edge (%d,%d)\n',coordinate(1)+x(j),coordinate(2)+y(j));
                    adjEdgeCount = adjEdgeCount + 1;

                    nextEdge(adjEdgeCount).val = PositionToVal([coordinate(1)+x(j),coordinate(2)+y(j)],env);

                end
            end    
        end

        % obtain next move and the direction of the move
        [nextNode, dir] = GetNextEdgeNode(edgeCircle.node(i).nodeNum,nextEdge,lastMove,env);
        
        edgeCircle.node(i).nextNode = nextNode;
        
       
        % store last node
        prevNode = edgeCircle.node(i).nodeNum; 
        lastMove = dir;
        
        % set first nodes prevNode to last node in edge circle list
        if(i == edgeNodeCount)
            edgeCircle.node(1).prevNode = edgeCircle.node(i).nodeNum;
        end
    end
    
    
end