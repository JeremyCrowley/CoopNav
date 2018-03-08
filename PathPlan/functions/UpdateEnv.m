% env = UpdateEnv(env, agent)
%
% updates the environment nodes based on location of agent
%
% env   - environment struct
% agent - agent struct


function env = UpdateEnv(env, agent)

    [m,n] = size(env.map);

    curCoords = ValToPosition(agent.currentNode, n)
    
    % update the discovered nodes
    for i = -agent.radiusOfView:agent.radiusOfView
        for j = -agent.radiusOfView:agent.radiusOfView            
            
            if(curCoords(1)+i >= 1 && curCoords(1)+i <= n && curCoords(2)+j >= 1 && curCoords(2)+j <= m)
                [curCoords(1), curCoords(2)]
                env.node(curCoords(1)+i, curCoords(2)+j).discovered = 1;
            end           
            
        end
    end
    
    % update the edge nodes
    for i = 1:n
        for j = 1:m
            if(env.node(i,j).discovered == 1)
                if(CheckIfEdge(env, [i j]))
                    env.node(i,j).edge = 1;
                    fprintf('found edge at (%d, %d)\n',i,j);
                else
                    env.node(i,j).edge = 0;
                end
            else
        end 
    end
    
    

end