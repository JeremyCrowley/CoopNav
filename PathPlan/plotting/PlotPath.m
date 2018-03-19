
function p = PlotPath(path, env, color)
    
    pathLength = length(path);

    for i = 1:pathLength-1
        
        c1 = ValToPosition(path(i),env);
        c2 = ValToPosition(path(i+1),env);
        
        p = plot([c1(1), c2(1)],[c1(2), c2(2)],color);
        
        
    end
    

end