% value = PositionToVal(coordinates, height, length)
%
% tranforms node coordinates to the node number

% TO DO - add height and valid check

function value = PositionToVal(coordinate, length)

    
    

    value = (coordinate(2)-1)*length+coordinate(1);

end