clear;clc;close all;

%% test creating and finding points of interest

% % % % % % % % % % % % % % % % % % % % % % % % 
% create a 8x8 environment with 4 obstacles   %
% % % % % % % % % % % % % % % % % % % % % % % % 

m = 8;
n = 9;

E1 = CreateEnv2D(m,n);

% AddSquare2D(env, corner, length, height)

E1 = AddSquare2D(E1,[3,4],4,1);
E1 = AddSquare2D(E1,[7,3],1,3);


% make and plot graph
G = MakeGraph(E1);
figure()
PlotGraph(G.Edges, E1);

% set sim parameters
radiusOfView = 3;
startPos = [1, 1];
target = [6,5];
targetNode = PositionToVal(target,E1);
startNode = PositionToVal(startPos,E1);

% create agent and update environment
A1 = CreateAgent(radiusOfView,startNode);




for i = 1:20
    agentCoord = ValToPosition(A1.currentNode, E1);
    fprintf('Agent at (%d, %d)\n',agentCoord(1),agentCoord(2));
    
    E1 = UpdateEnv(E1,A1);
    % create circular list of edge nodes
    circularEdgeLinkedList = GetMapEdge(E1);

    % find points of interest
    freeSpaceThreshold = 4;
    POI = FindPointsOfInterest(circularEdgeLinkedList, freeSpaceThreshold, E1);
    
    fprintf('Points of Interest: \n');
    disp(POI);
    
    numPOI = length(POI);

    % find shortests paths

    costList = zeros(1,numPOI);
    for j = 1:numPOI
        
        [path,d] = shortestpath(G,A1.currentNode,POI(j));
        costList(j) = PathCost(path,targetNode,E1);
    end
    
    [costMin, index] = min(costList);
    [path,d] = shortestpath(G,A1.currentNode,POI(index));

    if(length(path) == 1)
        nextNode = path(1);
    else
        nextNode = path(2);
    end
    A1.currentNode = nextNode;
end



%% Need to add

% 1. logic for when the target is in the discovered region

% 2. create a graph of the discovered nodes during simulation

% 3. fix logic for selecting certain POIs (especially for edge of the env
% nodes






