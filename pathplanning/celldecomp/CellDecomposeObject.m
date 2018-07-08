% function env = CellDecomposeObject(xlim, ylim, corner, width, height, env)
%
% takes in obstacle location data and adds the cell decomposed
% representation of the obstacle/object to the environment

function env = CellDecomposeObject(xlim, ylim, corner, width, height, env)
    [m,n] = size(env.map);
    
    xslice = xlim/m;
    yslice = ylim/n;
    
    xCell = ceil(corner(1)/xslice)
    yCell = ceil(corner(2)/yslice)
    
    widthCell = ceil((width/xslice))
    heightCell = ceil((height/yslice))
    
    env = AddSquare2D(env,[xCell,yCell],widthCell,heightCell);
    
end