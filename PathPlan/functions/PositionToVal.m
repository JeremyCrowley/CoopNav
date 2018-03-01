% value = PositionToVal(coordinates, length)
%
% tranforms node coordinates to the node number

function value = PositionToVal(coordinate, length)
    
    value = (coordinate(1)-1)*length+coordinate(2);

end