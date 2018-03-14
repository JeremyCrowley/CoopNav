clear;clc;close all;

%% test creating and finding points of interest

% % % % % % % % % % % % % % % % % % % % % % % % 
% create a 8x8 environment with 4 obstacles   %
% % % % % % % % % % % % % % % % % % % % % % % % 

m = 7;
n = 7;

E1 = CreateEnv2D(m,n);

% AddSquare2D(env, corner, length, height)
E1 = AddSquare2D(E1,[2,1],2,1);
E1 = AddSquare2D(E1,[6,6],1,1);
E1 = AddSquare2D(E1,[6,2],2,2);

% make and plot graph
G = MakeGraph(E1);
figure()
PlotGraph(G.Edges, E1);

% set sim parameters
radiusOfView = 2;
startPos = [3, 3];
startNode = PositionToVal(startPos,E1);

% create agent and update environment
A1 = CreateAgent(radiusOfView,startNode);
E1 = UpdateEnv(E1,A1);

% plot env
figure()
PlotEnv(E1, n, m);

% create circular list of edge nodes
circularEdgeLinkedList = GetMapEdge(E1);

% find points of interest
freeSpaceThreshold = 4;
POI = FindPointsOfInterest(circularEdgeLinkedList, freeSpaceThreshold, E1);

numPOI = length(POI);

% find shortests paths

d = zeros(1,numPOI);
for i = 1:numPOI
    [path(:,i),d(i)] = shortestpath(G,A1.currentNode,POI(i));
end

path

% eval cost function to target

% move forward one time step (one node)

% re evaluate the environment






