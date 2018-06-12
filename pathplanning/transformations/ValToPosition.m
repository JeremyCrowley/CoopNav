% value = ValToPosition(coordinates, length)
%
% tranforms node number to the node coordinates

function coordinate = ValToPosition(value, env)

    [envHeight, envLength] = size(env.map);

    coordinate(1) = value - floor(value/envLength)*envLength;
    coordinate(2) = ceil(value/envLength);
    
    if(coordinate(1) == 0)
        coordinate(1) = envLength;
    end

end