
function p = PlotPath(oldPathHandle, path, env, color)
    
    delete(oldPathHandle)

    pathLength = length(path);

    i = 1;
    
    % first case where 
    if(pathLength > 1)
        while(i<pathLength)

            c1 = ValToPosition(path(i),env);
            c2 = ValToPosition(path(i+1),env);

            p(i) = plot([c1(1), c2(1)],[c1(2), c2(2)],color);
            
            i = i+1;
        end        
    else
        p(i) = plot(0,0,'Visible','off');
    end
    

end