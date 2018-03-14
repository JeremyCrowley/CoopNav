% cost = PathCost(path,targetNode,env)

function cost = PathCost(path,targetNode,env)

    [m,n] = size(path);
      
    % convert to coordinates and calculate the distance between end point
    % and the target
    targetCoord = ValToPosition(targetNode,env);
    pathEndCoord = ValToPosition(path(end),env);
    cost = pdist([targetCoord;pathEndCoord],'euclidean');
 
end