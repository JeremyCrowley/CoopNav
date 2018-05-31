
function mocapCoords = CoordToMocap(simCoords, env)

	[envHeight, envLength] = size(env.map);
    [m,n] = size(simCoords);
    mocapCoords = zeros(m,n);
    
    
    mocapCoords(1,:) = 2*((simCoords(1,:)-1)/(envLength-1))-1;
    mocapCoords(2,:) = 2*((simCoords(2,:)-1)/(envHeight-1))-1;

end