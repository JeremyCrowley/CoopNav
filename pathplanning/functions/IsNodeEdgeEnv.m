

function edgeMapBool = IsNodeEdgeEnv(nodeNum, env)

    [envHeight, envLength] = size(env.map);
    
    coords = ValToPosition(nodeNum,env);
    
    edgeMapBool = 0;
    if(coords(1) == 1 || coords(2) == 1 || coords(1) == envLength || coords(2) == envHeight)
        edgeMapBool = 1;
    end

end