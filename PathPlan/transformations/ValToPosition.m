% value = ValToPosition(coordinates, length)
%
% tranforms node number to the node coordinates

function coordinate = ValToPosition(value, length)

    coordinate(1) = value - floor(value/length)*length;
    coordinate(2) = ceil(value/length);
    
    if(coordinate(1) == 0)
        coordinate(1) = length;
    end

end