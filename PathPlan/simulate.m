

%% Navigation with agent
% % % % % % % % % % % % % % % % % % % % % % % % 
% create a 8x8 environment with 4 obstacles   %
% % % % % % % % % % % % % % % % % % % % % % % % 
function simulate(m,n)


    E1 = CreateEnv2D(m,n);

    % AddSquare2D(env, corner, length, height)


    E1 = AddSquare2D(E1,[3,3],3,1);
    E1 = AddSquare2D(E1,[3,8],3,1);
    E1 = AddSquare2D(E1,[4,15],6,2);
    E1 = AddSquare2D(E1,[5,9],1,2);
    E1 = AddSquare2D(E1,[6,1],1,8);
    E1 = AddSquare2D(E1,[10,8],1,9);
    E1 = AddSquare2D(E1,[10,3],1,2);
    E1 = AddSquare2D(E1,[11,10],2,1);
    E1 = AddSquare2D(E1,[14,14],3,1);


    %figure(1)
    %PlotCellDecomp(E1);
    %pause(20)



    % make and plot graph
    G = MakeGraph(E1);

    % set sim parameters
    radiusOfView = 3;
    startPos = [1, 1];
    targetCoord = [16,16];
    targetNode = PositionToVal(targetCoord,E1);
    startNode = PositionToVal(startPos,E1);

    % create agent and update environment
    A1 = CreateAgent(radiusOfView,startNode);

    % set initial handles
    
    pDiscovered = plot(0,0);
    pPOI = plot(0,0);
    pAgent = plot(0,0);
    pCell = plot(0,0);



    iterations = 36;

    pause(5)

    agentPath = zeros(1,iterations);
    for i = 1:iterations

        agentPath(i) = A1.currentNode;

        agentCoord = ValToPosition(A1.currentNode, E1);
        fprintf('Agent at (%d, %d)\n',agentCoord(1),agentCoord(2));

        E1 = UpdateEnv(E1,A1);
        % create circular list of edge nodes
        circularEdgeLinkedList = GetMapEdge(E1);

        % find points of interest
        freeSpaceThreshold = 4;
        POI = FindPointsOfInterest(circularEdgeLinkedList, freeSpaceThreshold, E1, targetNode);



        numPOI = length(POI);

        % find shortests paths

        costList = zeros(1,numPOI);
        for j = 1:numPOI

            [path,d] = shortestpath(G,A1.currentNode,POI(j));
            costList(j) = PathCost(path,targetNode,E1);
        end

        fprintf('Points of Interest: \n');
        %disp(POI);
        %disp(costList);
        [costMin, index] = min(costList);
        [path,d] = shortestpath(G,A1.currentNode,POI(index));


        [pCell,pDiscovered,pPOI,pAgent] = PlotGraph(G.Edges,circularEdgeLinkedList,POI, E1, A1,pCell,pDiscovered,pPOI,pAgent);
        drawnow;

        % choose next node

        if(length(path) == 1)
            nextNode = path(1);
        else
            nextNode = path(2);
        end

        % trace agents trajectory
        c1 = ValToPosition(A1.currentNode,E1);
        c2 = ValToPosition(nextNode,E1);
        plot([c1(1),c2(1)],[c1(2),c2(2)],'green','LineWidth',3);


        % set next node
        A1.currentNode = nextNode;

        %PlotAgentPath(agentPath, E1);

        %pause(2)

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
    