% env = UpdateEnv(env, agent)
%
% updates the environment nodes based on location of agent
%
% env   - environment struct
% agent - agent struct


function env = UpdateEnv(env, agent)

    [envHeight,envLength] = size(env.map);

    curCoords = ValToPosition(agent.currentNode, env);
    
    % update the discovered nodes
    for i = -agent.radiusOfView:agent.radiusOfView
        for j = -agent.radiusOfView:agent.radiusOfView            
            
            if(IsCoordValid([curCoords(1)+i,curCoords(2)+j],env))
                arrIndex = CoordToArray([curCoords(1)+i,curCoords(2)+j], env);
                env.node(arrIndex(1), arrIndex(2)).discovered = 1;
            end           
            
        end
    end
    
    % update the edge nodes
    for i = 1:envLength
        for j = 1:envHeight
            arrIndex = CoordToArray([i,j],env);
            if(env.node(arrIndex(1),arrIndex(2)).discovered == 1)
                if(CheckIfEdge(env, [i,j]))
                    env.node(arrIndex(1),arrIndex(2)).edge = 1;
                    %fprintf('found edge at (%d, %d)\n',i,j);
                else
                    env.node(arrIndex(1),arrIndex(2)).edge = 0;
                end
            end
        end 
    end
end