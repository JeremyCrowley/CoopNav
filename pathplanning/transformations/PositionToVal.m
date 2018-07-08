% value = PositionToVal(coordinates, height, length)
%
% transforms node coordinates to the node number



function value = PositionToVal(coordinate, env)

    [envHeight, envLength] = size(env.map);

    value = (coordinate(2)-1)*envLength+coordinate(1);

end