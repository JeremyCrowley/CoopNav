% edgeBool = CheckIfEdge(env, nodeCoords)


function edgeBool = CheckIfEdge(env, nodeCoords)

    [m,n] = size(env.map);
    edgeBool = 0;
    
    arrIndex = CoordToArray(nodeCoords, env);
    
    if(env.node(arrIndex(1), arrIndex(2)).discovered == 1)
        for i = -1:1
            for j = -1:1
                if(i ~= 0 || j ~= 0)
                    if(IsCoordValid([nodeCoords(1)+i, nodeCoords(2)+j],env))
                        
                        surroundingArrIndex = CoordToArray([nodeCoords(1)+i, nodeCoords(2)+j], env);
                        if(env.node(surroundingArrIndex(1), surroundingArrIndex(2)).discovered == 0)
                            edgeBool = 1;
                        end
                    end
                end
            end
        end
    end
end