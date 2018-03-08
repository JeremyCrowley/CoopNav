% env = CreateEnv2D(length,height)
%
% creates a 2 dimensional map for simulation
%

function env = CreateEnv2D(length,height)
    env.map = zeros(length,height);
    env.objs = [];
    env.numObj = 0;
    
    for i = 1:length
        for j = 1:height
            env.node(i,j).discovered = 0;
            env.node(i,j).edge = 0;
        end
    end  
    
end