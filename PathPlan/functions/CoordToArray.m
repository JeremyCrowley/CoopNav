% arrayIndex = CoordToArray(coordinate, env)
%
% transforms the desired coordinates to the array indices

function arrayIndex = CoordToArray(coordinate, env)

    [envHeight, envLength] = size(env.map);
     
    arrayIndex = [envHeight-coordinate(2)+1,coordinate(1)];
   
end