% env = CreateEnv2D(length,height)
%
% creates a 2 dimensional map/environment for simulation


function env = CreateEnv2D(height,length)
    env.map = zeros(height,length);
    env.objs = [];
    env.numObj = 0;
    env.numEdgeNodes = 0;
    
    for i = 1:length
        for j = 1:height
            
            arrIndex = CoordToArray([i,j],env);
            
            env.node(arrIndex(1),arrIndex(2)).discovered = 0;
            env.node(arrIndex(1),arrIndex(2)).edge = 0;
        end
    end  
    
end