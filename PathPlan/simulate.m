

%% Navigation with agent
% % % % % % % % % % % % % % % % % % % % % % % % 
% create a 8x8 environment with 4 obstacles   %
% % % % % % % % % % % % % % % % % % % % % % % % 
function simulate(E1,G,startCoord,targetCoord,radiusOfView,iterations)
    
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



    

    pause(5)

    agentPath = zeros(1,iterations);
    for i = 1:iterations

        % get current node of agents path
        agentPath(i) = A1.currentNode;
        agentCoord = ValToPosition(A1.currentNode, E1);
        fprintf('Agent at (%d, %d)\n',agentCoord(1),agentCoord(2));

        % update discovered and edge nodes based on agent location
        E1 = UpdateEnv(E1,A1);
        
        % call path planning algorithm
        [nextCoord, circularEdgeLinkedList, POI] = PathPlan(E1, G, A1, targetNode);
    
        % plot
        [pCell,pDiscovered,pPOI,pAgent] = PlotGraph(G.Edges,circularEdgeLinkedList,POI, E1, A1,pCell,pDiscovered,pPOI,pAgent);
        drawnow;
        
        
        % set next node
        nextNode = PositionToVal(nextCoord,E1);
        A1.currentNode = nextNode;

        pause(5)
        
    end
    
    
    delete(pAgent);
    pAgent = scatter(c2(1),c2(2),50,[0 1 0],'*');

end



    %% Need to add

    % 1. create a graph of the discovered nodes during simulation

    % 2. fix the issue when there are multiple edges in the map

    % 3. improve optimization

    %% Note

    % Oscillatory behavior noticed when POI weights are equal and grow equally
    % when traveling towards it.
    