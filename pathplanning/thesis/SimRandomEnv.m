
% function SimRandomEnv(m,n,numObjs) 
%
%
% adds numObjs number of 1x1 objects randomly on the map
% (obj cannot be on the start coord or the target coord)

function timeTaken = SimRandomEnv(m,n,numObjs)

    % set the number of iterations
    numIterations = m-3;
    
    % create environment
    E = CreateEnv2D(m,n);
    
    
    xy = zeros(numObjs,2);
    % generate random placement for objects
    [mUnique,nUnique] = size(unique(xy,'rows'));
    while(length(xy) ~= mUnique)
        xy = randi(m-4,numObjs,2)+2;
        [mUnique,nUnique] = size(unique(xy,'rows'));
    end
    
    % add objects
    for i = 1:numObjs
        E = AddSquare2D(E,[xy(i,1),xy(i,2)],1,1);
    end
    
    
    
    % create digraph
    G = MakeGraph(E);
    
    % set sim params
    startCoord = [1, 1];
    targetCoord = [m, n];
    dispPOI = 0;

    i = 3;
    timeTaken = zeros(1,numIterations);
    while(i < m)
        radiusOfView = i;
        
        % simulate
        f = figure();
        [iterations,pDiscovered,pPOI,pAgent,pCell,pPath,agentPath,distanceToTarget,timeline] = simulate(E,G,startCoord,targetCoord,radiusOfView,dispPOI)
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