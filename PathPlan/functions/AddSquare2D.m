function env = AddSquare2D(environment,corner,length,width,height)
    
    environment.map(corner(1):corner(1)+length-1,corner(2):corner(2)+width-1) = ones(length,width);
    
    v1 = corner;
    v2 = [corner(1)+length-1    ,corner(2)];
    v3 = [corner(1)+length-1    ,corner(2)+width-1];
    v4 = [corner(1)             ,corner(2)+width-1];
    
    
    if(environment.numObj == 0)
        environment.objs(:,:,1) = [v1;v2;v3;v4];
    else
        environment.objs(:,:,end+1) = [v1;v2;v3;v4];
    end
        
    environment.numObj = environment.numObj+1; 
    
    env = environment;
end