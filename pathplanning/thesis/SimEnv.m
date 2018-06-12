

function timeTaken = SimEnv(env)

    [m,n] = size(env.map);
    
    numIterations = m-2;
    % create digraph
    G = MakeGraph(env);
    
    % set sim params
    startCoord = [1, 1];
    targetCoord = [m, n];
    dispPOI = 0;

    i = 3;
    timeTaken = zeros(1,numIterations);
    
    while(i < m+1)
        radiusOfView = i;
        
        % simulate
        f = figure();
        [iterations,pDiscovered,pPOI,pAgent,pCell,pPath,agentPath,distanceToTarget,timeline] = simulate(env,G,startCoord,targetCoord,radiusOfView,dispPOI);
        close(f)
    
        % overlay time distance to target v time
        %figure(100)
        %[dm, dn] = size(distanceToTarget);
        %plot(timeline,distanceToTarget)
        %hold on
        
        timeTaken(i-2) = timeline(end);

        i = i + 1;
    end




end