% p = PlotCellDecomp(env)

function p = PlotCellDecomp(env)

    % show cell decomposition - obstacle, obstacle boundary, free space
    [envHeight,envLength] = size(env.map);
   
    
    for i = 1:envLength
        for j = 1:envHeight
            
            arrIndex = CoordToArray([i,j],env);
            if(env.map(arrIndex(1),arrIndex(2)) == 2)
                color = 'red';
            elseif(env.map(arrIndex(1),arrIndex(2)) == 1)
                color = 'blue';
            else
                color = 'green';
            end
            
            k = PositionToVal([i,j],env);
            p(k) = PlotSquare([i,j],color,0.15);
            
            
            
            if(env.node(arrIndex(1),arrIndex(2)).discovered == 0)
                color = [0 0 0];
            elseif(env.node(arrIndex(1),arrIndex(2)).edge == 1)
                color = [0 1 0];
            else
                color = [1 0 0];
            end
            
            
            val = PositionToVal([i,j], env);

            
            %annot = sprintf('%d',val);
            %p(k+envHeight*envLength) = text(i-0.2,j-0.2,annot);
            
        end
    end
    
    xlim([0 envLength+1]);
    ylim([0 envHeight+1]);

end