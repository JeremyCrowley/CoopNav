% coordinate = ArrayToCoord(arrayIndex, env)
%
% transforms the desired array indices to coordinates

function coordinate = ArrayToCoord(arrayIndex, env)
    
    [envHeight, envLength] = size(env.map);
    
    coordinate = [arrayIndex(2),envHeight-arrayIndex(1)+1];

end