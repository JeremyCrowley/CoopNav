% env = AddSquare2D(environment,corner,length,height)

function env = AddSquare2D(env,corner,sqrLength,sqrHeight)
    
    [envHeight, envLength] = size(env.map);
    
    % make sure that the obstacle is within the environment map
    if(corner(2) < 1 || corner(1) < 1 || corner(2) > envHeight || corner(1) > envLength)
        error('Error: corner (%d,%d) is not in the environment',corner(1),corner(2));
    end
    
    if(corner(2)+(sqrHeight-1) > envHeight && corner(1)+(sqrLength-1) > envLength)
        error('Error: length %d and height %d are too large with corner (%d,%d)',sqrHeight,sqrLength,corner(1),corner(2));
    elseif(corner(2)+(sqrHeight-1) > envHeight)
        error('Error: height %d is too large with corner (%d,%d)',sqrLength,corner(1),corner(2));
    elseif(corner(1)+(sqrLength-1) > envLength)
        error('Error: length %d is too large with corner (%d,%d)',sqrHeight,corner(1),corner(2));
    end
    
    % get array index of top left corner of obstacle to iterate and add
    arrCornerIndex = CoordToArray([corner(1),corner(2)], env);
    topLeftCornerIndex = [arrCornerIndex(1)-sqrHeight+1,arrCornerIndex(2)];
    
    % make sure each obstacle is unique (i.e. not overlapping)
    for i = 0:sqrHeight-1
        for j = 0:sqrLength-1
            if(env.map(topLeftCornerIndex(1)+i,topLeftCornerIndex(2)+j) == 2)
                error('Error: overlapping obstacles at (%d,%d)',corner(1)+i,corner(2)+j);
            end
        end
    end
    
    % add obstacle boundary
    for i = -1:sqrHeight
        for j = -1:sqrLength
            
            % check if in map
            curCoord = ArrayToCoord([topLeftCornerIndex(1)+i,topLeftCornerIndex(2)+j],env);
            
            if(~IsCoordValid(curCoord,env))
                
                %fprintf('position (%d,%d) not in map\n',curCoord(1),curCoord(2))
                continue
                
            % check if obstacle:
            % - do not replace obstacle with obstacle boundary
            % - obstacles can be touching, not overlapping
            
            elseif(env.map(topLeftCornerIndex(1)+i,topLeftCornerIndex(2)+j) == 2) 
                %fprintf('position (%d,%d) already obstacle\n',curCoord(1)+i,curCoord(2)+j)
                continue
            else
                env.map(topLeftCornerIndex(1)+i,topLeftCornerIndex(2)+j) = 1;
            end
            
        end
    end
    
    env.map(arrCornerIndex(1)-sqrHeight+1:arrCornerIndex(1),arrCornerIndex(2):arrCornerIndex(2)+sqrLength-1) = 2*ones(sqrHeight,sqrLength);
    
    % vertices of the square
    %{
    v1 = corner;
    v2 = [corner(1)+sqrHeight-1    ,corner(2)];
    v3 = [corner(1)+sqrHeight-1    ,corner(2)+sqrLength-1];
    v4 = [corner(1)             ,corner(2)+sqrLength-1];
    
    % add object to environment list of objs
    if(env.numObj == 0)
        env.objs(:,:,1) = [v1;v2;v3;v4];
    else
        env.objs(:,:,end+1) = [v1;v2;v3;v4];
    end
    %}
    % increment obj count
    env.numObj = env.numObj+1; 
    
    

end