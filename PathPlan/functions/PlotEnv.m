
function p = PlotEnv(env, length, height)
    
    figure()
    for i = 1:length
        for j = 1:height
            if(env.node(i,j).discovered == 0)
                scatter(i,j,10,[0 0 0]);
            elseif(env.node(i,j).edge == 1)
                scatter(i,j,10,[0 1 0]);
            else
                scatter(i,j,10,[1 0 0]);
            end

            hold on
        end
    end

end