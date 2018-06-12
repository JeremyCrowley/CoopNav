

%% Navigation with agent
% % % % % % % % % % % % % % % % % % % % % % % % 
% create a 8x8 environment with 4 obstacles   %
% % % % % % % % % % % % % % % % % % % % % % % % 
function [iterations,pDiscovered,pPOI,pAgent,pCell,pPath,agentPath,distanceToTarget,timeline] = simulate(E1,G,startCoord,targetCoord,radiusOfView,dispPOI)
    
    % convert sim parameter
    targetNode = PositionToVal(targetCoord,E1);
    startNode = PositionToVal(startCoord,E1);

    % create agent and update environment
    A1 = CreateAgent(radiusOfView,startNode);

    % set initial handles
    
    pDiscovered = scatter(0,0,'Visible','off');
    pPOI = scatter(0,0,'Visible','off');
    pAgent = scatter(0,0,'Visible','off');
    pCell = scatter(0,0,'Visible','off');
    pPath = scatter(0,0,'Visible','off');


    

    %pause(5)

    agentPath = [];
    i = 1;
    while(A1.currentNode ~= targetNode)

        % get current node of agents path
        agentPath = [agentPath A1.currentNode];
        pPath = PlotPath(pPath,agentPath,E1,'black');
        agentCoord = ValToPosition(A1.currentNode, E1);
        fprintf('Agent at (%d, %d)\n',agentCoord(1),agentCoord(2));

        % update discovered and edge nodes based on agent location
        E1 = UpdateEnv(E1,A1);
        
        % call path planning algorithm
        [nextCoord, circularEdgeLinkedList, POI] = PathPlan(E1, G, A1, targetNode);
    
        % plot
        [pCell,pDiscovered,pPOI,pAgent] = PlotGraph(G.Edges,circularEdgeLinkedList,POI, E1, A1,pCell,pDiscovered,pPOI,pAgent,dispPOI);
        drawnow;
        
       
        
        % set next node
        nextNode = PositionToVal(nextCoord,E1);
        A1.currentNode = nextNode;

        
        i = i+1;
        
    end    
    
    % update last movement from agent
    agentPath = [agentPath A1.currentNode];
    pPath = PlotPath(pPath,agentPath,E1,'black');
    delete(pAgent);
    pAgent = scatter(targetCoord(1),targetCoord(2),50,[0 1 0],'*');

    % for returning number of interations
    iterations = i-1;
    
    [m,n] = size(agentPath);
    distanceToTarget = zeros(1,n);
    for i = 1:n
        crd = ValToPosition(agentPath(i),E1);
        distanceToTarget(i) = norm(targetCoord-crd);
    end
    
    timeline = zeros(1,n);
    timeline(1) = 0;
    for i = 1:n-1
        crd1 = ValToPosition(agentPath(i),E1);
        crd2 = ValToPosition(agentPath(i+1),E1);
        
        if(crd1(1) == crd2(1) || crd1(2) == crd2(2))
            timeline(i+1) = timeline(i)+1;
        else
            timeline(i+1) = timeline(i)+sqrt(2);
        end
    end
    
end



    %% Need to add

    % 1. create a graph of the discovered nodes during simulation

    % 2. fix the issue when there are multiple edges in the map

    % 3. improve optimization

    %% Note

    % Oscillatory behavior noticed when POI weights are equal and grow equally
    % when traveling towards it.
    