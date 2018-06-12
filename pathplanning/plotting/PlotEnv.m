% p = PlotEnv(env, length, height)

% PROBLEMS WITH THIS FUNCTION

function p = PlotEnv(env, length, height)

    for i = 1:length
        for j = 1:height
            
            if(env.node(i,j).discovered == 0)
                color = [0 0 0];
            elseif(env.node(i,j).edge == 1)
                color = [0 1 0];
            else
                color = [1 0 0];
            end
            
            coordinate = ArrayToCoord([i,j], env);
            val = PositionToVal(coordinate, env);
            
            scatter(coordinate(1),coordinate(2),10,color);
            
            annot = sprintf('%d',val);
            text(coordinate(1),coordinate(2),annot)


            hold on
        end
    end

end