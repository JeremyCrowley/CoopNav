% validBool = IsCoordValid(coordinates, env)
%
% check coordinate is valid


function validBool = IsCoordValid(coordinate, env)

    arrIndex = CoordToArray(coordinate,env);

    [height, length] = size(env.map);
    
    validBool = 0;

    % check that the coordinates lie withing the boundaries of the map
    if(arrIndex(1) >= 1 && arrIndex(1) <= height && arrIndex(2) >= 1 && arrIndex(2) <= length)
        validBool = 1;
    end
end