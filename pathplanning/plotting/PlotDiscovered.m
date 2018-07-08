% p = PlotDiscovered(env)
%
% plots black cells over the undiscovered cells in the environment

function p = PlotDiscovered(env)

    % delete old handles

    [envHeight, envLength] = size(env.map);
    
    % undiscovered count
    j = 1;
    
    for i = 1:envHeight*envLength
        
        
        center = ValToPosition(i,env);
        arrIndex = CoordToArray(center,env);
        
        if(~(env.node(arrIndex(1),arrIndex(2)).discovered))
            

            x = [center(1)-0.5 center(1)-0.5 center(1)+0.5 center(1)+0.5]; 
            y = [center(2)-0.5 center(2)+0.5 center(2)+0.5 center(2)-0.5]; 


            p(j) = patch(x,y,[0,0,0],'LineWidth',1);
            j = j+1;
        end
    end
    
    if(j == 1)
        p = scatter(0,0,'Visible','off');
    end


end