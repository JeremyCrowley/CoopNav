% edgeBool = CheckIfEdge(env, nodeCoords)


function edgeBool = CheckIfEdge(env, nodeCoords)

    [m,n] = size(env.map);
    edgeBool = 0;
    
    if(env.node(nodeCoords(1), nodeCoords(2)).discovered == 1)
        for i = -1:1
            for j = -1:1
                if(i ~= 0 || j ~= 0)
                    if(nodeCoords(1)+i >= 1 && nodeCoords(1)+i <= n && nodeCoords(2)+j >= 1 && nodeCoords(2)+j <= m)

                        if(env.node(nodeCoords(1)+i, nodeCoords(2)+j).discovered == 0)
                            edgeBool = 1;
                        end
                    end
                end
            end
        end
    end
end