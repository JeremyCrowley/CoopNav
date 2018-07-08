% cost = PathCost(path,targetNode,env)
%
% calculates the cost of the planned trajectory as the distance between the
% final coordinate in the trajectory and the target coordinate

function cost = PathCost(path,targetNode,env)

    [m,n] = size(path);
      
    % convert to coordinates and calculate the distance between end point
    % and the target
    targetCoord = ValToPosition(targetNode,env);
    pathEndCoord = ValToPosition(path(end),env);
    cost = pdist([targetCoord;pathEndCoord],'euclidean');
 
end