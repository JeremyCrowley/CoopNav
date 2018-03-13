% value = PositionToVal(coordinates, height, length)
%
% tranforms node coordinates to the node number

% TO DO - add height and valid check

function value = PositionToVal(coordinate, env)

    [envHeight, envLength] = size(env.map);

    value = (coordinate(2)-1)*envLength+coordinate(1);

end