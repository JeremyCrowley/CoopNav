clear;clc;close all;

%% Navigation with agent
% % % % % % % % % % % % % % % % % % % % % % % % 
% create a 8x8 environment with 4 obstacles   %
% % % % % % % % % % % % % % % % % % % % % % % % 

m = 20;
n = 20;

E1 = CreateEnv2D(m,n);

% AddSquare2D(env, corner, length, height)

E1 = AddSquare2D(E1,[3,9],5,1);
E1 = AddSquare2D(E1,[3,4],5,1);
E1 = AddSquare2D(E1,[8,1],3,4);
E1 = AddSquare2D(E1,[8,5],1,8);
E1 = AddSquare2D(E1,[12,1],2,7);
E1 = AddSquare2D(E1,[12,11],1,4);
E1 = AddSquare2D(E1,[12,15],6,2);
E1 = AddSquare2D(E1,[17,10],1,5);
E1 = AddSquare2D(E1,[18,5],1,6);
E1 = AddSquare2D(E1,[18,14],1,7);



figure(1)
PlotCellDecomp(E1);
%pause(20)
% make and plot graph
G = MakeGraph(E1);

% set sim parameters
radiusOfView = 2;
startPos = [8, 14];
targetCoord = [14,14];
targetNode = PositionToVal(targetCoord,E1);
startNode = PositionToVal(startPos,E1);

% create agent and update environment
A1 = CreateAgent(radiusOfView,startNode);

% set initial handles
pDiscovered = plot(0,0);
pPOI = plot(0,0);
pAgent = plot(0,0);
pCell = plot(0,0);

figure(2)

iterations = 3;


agentPath = zeros(1,iterations);
for i = 1:iterations
    
    agentPath(i) = A1.currentNode;
    
    agentCoord = ValToPosition(A1.currentNode, E1);
    fprintf('Agent at (%d, %d)\n',agentCoord(1),agentCoord(2));
    
    E1 = UpdateEnv(E1,A1);
    % create circular list of edge nodes
    circularEdgeLinkedList = GetMapEdge(E1);

    % find points of interest
    freeSpaceThreshold = 8;
    POI = FindPointsOfInterest(circularEdgeLinkedList, freeSpaceThreshold, E1, targetNode);
    
    
    
    numPOI = length(POI);

    % find shortests paths

    costList = zeros(1,numPOI);
    for j = 1:numPOI
        
        [path,d] = shortestpath(G,A1.currentNode,POI(j));
        costList(j) = PathCost(path,targetNode,E1);
    end
    
    fprintf('Points of Interest: \n');
    disp(POI);
    disp(costList)
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
    plot([c1(1),c2(1)],[c1(2),c2(2)],'green');
    
    
    % set next node
    A1.currentNode = nextNode;
    
    %PlotAgentPath(agentPath, E1);
    
    %pause(2)
    
end

delete(pAgent);
pAgent = scatter(c2(1),c2(2),50,[0 1 0],'*');





%% Need to add

% 1. logic for when the target is in the discovered region

% 2. create a graph of the discovered nodes during simulation

% 3. fix logic for selecting certain POIs (especially for edge of the env
% nodes


%% Note

% Oscillatory behavior noticed when POI weights are equal and grow equally
% when traveling towards it.