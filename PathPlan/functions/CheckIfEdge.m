% edgeBool = CheckIfEdge(env, nodeCoords)


function edgeBool = CheckIfEdge(env, nodeCoords)

    [m,n] = size(env.map);
    edgeBool = 0;
    
    arrIndex = CoordToArray(nodeCoords, env);
    
    % make sure initial coord has been discovered
    if(env.node(arrIndex(1), arrIndex(2)).discovered == 1)
        for i = -1:1
            for j = -1:1
                
                % do not against self
                if(i ~= 0 || j ~= 0)
                    if(IsCoordValid([nodeCoords(1)+i, nodeCoords(2)+j],env))
                        
                        % check if adj node has not been discovered
                        surroundingArrIndex = CoordToArray([nodeCoords(1)+i, nodeCoords(2)+j], env);
                        if(env.node(surroundingArrIndex(1), surroundingArrIndex(2)).discovered == 0)
                            edgeBool = 1;
                        end
                        
                    % discovered and edge of the env makes it an edge node
                    else
                        edgeBool = 1;
                    end
                end
            end
        end
    end
end