% env = AddSquare2D(environment,corner,length,height)

function env = AddSquare2D(environment,corner,length,height)
    
    [rowNum, colNum] = size(environment.map);
    
    % make sure that the obstacle is within the environment map
    if(corner(1) < 1 || corner(2) < 1 || corner(1) > rowNum || corner(2) > colNum)
        error('Error: initial corner (%d,%d) is not in the environment',corner(1),corner(2));
    end
    
    if(corner(1)+(height-1) > rowNum && corner(2)+(length-1) > colNum)
        error('Error: length %d and height %d are too large with corner (%d,%d)',length,height,corner(1),corner(2));
    elseif(corner(1)+(height-1) > rowNum)
        error('Error: height %d is too large with corner (%d,%d)',height,corner(1),corner(2));
    elseif(corner(2)+(length-1) > colNum)
        error('Error: length %d is too large with corner (%d,%d)',length,corner(1),corner(2));
    end
    
    % make sure each obstacle is unique (i.e. not overlapping0
    for i = 0:height-1
        for j = 0:length-1
            if(environment.map(corner(1)+i,corner(2)+j) == 2)
                error('Error: overlapping obstacles at (%d,%d)',corner(1)+i,corner(2)+j);
            end
        end
    end
    
    % add obstacle boundary
    for i = -1:height
        for j = -1:length
            
            % check if in map
            if(corner(1)+i<1 || corner(2)+j<1 || corner(1)+i>rowNum || corner(2)+j>colNum)
                fprintf('position (%d,%d) not in map\n',corner(1)+i,corner(2)+j)
            % check if obstacle:
            % - do not replace obstacle with obstacle boundary
            % - obstacles can be touching, not overlapping
            elseif(environment.map(corner(1)+i,corner(2)+j) == 2)
                fprintf('position (%d,%d) already obstacle\n',corner(1)+i,corner(2)+j)
            else
               environment.map(corner(1)+i,corner(2)+j) = 1;
            end
            
        end
    end
    

    
    %environment.map(corner(1)-1:corner(1)+height-1+1,corner(2)-1:corner(2)+length-1+1) = ones(height+2,length+2);
    environment.map(corner(1):corner(1)+height-1,corner(2):corner(2)+length-1) = 2*ones(height,length);
    
    v1 = corner;
    v2 = [corner(1)+length-1    ,corner(2)];
    v3 = [corner(1)+length-1    ,corner(2)+height-1];
    v4 = [corner(1)             ,corner(2)+height-1];
    
    
    if(environment.numObj == 0)
        environment.objs(:,:,1) = [v1;v2;v3;v4];
    else
        environment.objs(:,:,end+1) = [v1;v2;v3;v4];
    end
        
    environment.numObj = environment.numObj+1; 
    
    env = environment;
end