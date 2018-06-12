
function edgeNodes = FindEdgeNodes(env)

    [envHeight, envLength] = size(env.map);

    % find edge nodes 
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
end