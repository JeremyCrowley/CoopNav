% nextNode = ChooseBestPath(paths, targetNode, env)

function nextNode = ChooseBestPath(paths, targetNode, env)
    
    
    [m,n] = size(paths);
    
    % find cost for all paths
    costList = zeros(1,n);
    for i = 1:n
        costList(i) = PathCost(paths(:,i),targetNode, env);
    end
    
    % select next node in min cost path
    [costMin, index] = min(costList);
    nextNode = paths(index,2);

end