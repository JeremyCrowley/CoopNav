% value = PositionToVal(coordinates, length)
%
% tranforms node coordinates to the node number

function value = PositionToVal(coordinate, length)
    
    value = (coordinate(2)-1)*length+coordinate(1);

end