

function bool = IsCoordObst(coord,env)

    arrInd = CoordToArray(coord,env);
    
    if(env.map(arrInd(1),arrInd(2) == 2))
        bool = 1;
    else
        bool = 0;
    end
    
end