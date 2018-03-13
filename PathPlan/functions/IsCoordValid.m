% validBool = IsCoordValid(coordinates, env)
%
% check coordinate is valid


function validBool = IsCoordValid(coordinate, env)

    [height, length] = size(env.map);
    
    validBool = 0;

    % check that the coordinates lie withing the boundaries of the map
    if(coordinate(1) >= 1 && coordinate(1) <= length && coordinate(2) >= 1 && coordinate(2) <= height)
        validBool = 1;
    end
end