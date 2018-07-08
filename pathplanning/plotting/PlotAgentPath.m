% p = PlotAgentPath(agentPath, env)
%
% plots the path of the agent


function p = PlotAgentPath(agentPath, env)

    [envHeight, envLength] = size(env.map);
    n = length(agentPath);
    for i = 1:n-1    
        
        c1 = ValToPosition(agentPath(i),env);
        c2 = ValToPosition(agentPath(i+1),env);
        
        p(i) = plot([c1(1),c2(1)],[c1(2),c2(2)]);
    end

end