

clear;clc;close all;

%% Navigation with agent
 

m = 16;
n = 14;

E1 = CreateEnv2D(m,n);
% AddSquare2D(env, corner, length, height)

E1 = AddSquare2D(E1,[3,7],1,8);
E1 = AddSquare2D(E1,[8,12],4,2);
E1 = AddSquare2D(E1,[10,6],2,3);


% make and plot graph
G = MakeGraph(E1);

% set sim parameters
radiusOfView = 3;
startPos = [6, 8];
targetCoord = [14,14];

targetNode = PositionToVal(targetCoord,E1);
startNode = PositionToVal(startPos,E1);

% create agent and update environment
A1 = CreateAgent(radiusOfView,startNode);

E1 = UpdateEnv(E1,A1);
% create circular list of edge nodes
circularEdgeLinkedList = GetMapEdge(E1);

% find points of interest
freeSpaceThreshold = 6;
POI = FindPointsOfInterest(circularEdgeLinkedList, freeSpaceThreshold, E1, targetNode);
numPOI = length(POI);

% find shortests paths
costList = zeros(1,numPOI);
agentCoords = ValToPosition(A1.currentNode,E1);

%% Edge of known environment
figure(1)
hold on
PlotDiscovered(E1);
PlotCellDecomp(E1);
p = PlotDiscoveredEdge(circularEdgeLinkedList,E1);
pAgent = scatter(agentCoords(1),agentCoords(2),100,[0 1 0],'filled');
pTarget = scatter(targetCoord(1),targetCoord(2),100,[1 0 0],'*');
xlabel('x axis');
ylabel('y axis');
h = zeros(3, 1);
h(1) = scatter(NaN,NaN,100,'filled','green');
h(2) = scatter(NaN,NaN,50,'*','red');
h(3) = plot(NaN,NaN,'color',[0 0 0],'LineWidth',3);
legend(h,'Location','northwest','Quadrotor','Target','Discovered edge');
title('Edge of Known Environment')

%% Selected Points of Interest
figure(2)
hold on
PlotDiscovered(E1);
PlotCellDecomp(E1);
PlotPOI(POI,E1);
pAgent = scatter(agentCoords(1),agentCoords(2),100,[0 1 0],'filled');
pTarget = scatter(targetCoord(1),targetCoord(2),100,[1 0 0],'*');
xlabel('x axis');
ylabel('y axis');
h = zeros(3, 1);
h(1) = scatter(NaN,NaN,100,'filled','green');
h(2) = scatter(NaN,NaN,50,'*','red');
h(3) = scatter(NaN,NaN,50,'filled','red');
legend(h,'Location','northwest','Quadrotor','Target','P.O.I.');
title('Points of Interest')








