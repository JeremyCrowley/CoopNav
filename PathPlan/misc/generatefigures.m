clear;clc;close all;

%% Navigation with agent
% % % % % % % % % % % % % % % % % % % % % % % % 
% create a 8x8 environment with 4 obstacles   %
% % % % % % % % % % % % % % % % % % % % % % % % 

m = 16;
n = 14;

E1 = CreateEnv2D(m,n);
% AddSquare2D(env, corner, length, height)

E1 = AddSquare2D(E1,[3,7],1,8);
E1 = AddSquare2D(E1,[8,12],4,2);
E1 = AddSquare2D(E1,[10,6],2,3);


%figure(1)
%PlotCellDecomp(E1);

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





%% PLOT STEP 0 - Initial state of simulation
%% PLOT STEP 1 - find P.O.I. and plan paths


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

figure(1)
hold on
PlotDiscovered(E1);
PlotCellDecomp(E1);
pAgent = scatter(agentCoords(1),agentCoords(2),100,[0 1 0],'filled');
pTarget = scatter(targetCoord(1),targetCoord(2),100,[1 0 0],'*');
xlabel('x axis');
ylabel('y axis');
h = zeros(2, 1);
h(1) = scatter(NaN,NaN,100,'filled','green');
h(2) = scatter(NaN,NaN,50,'*','red');
legend(h,'Location','northwest','Quadrotor','Target');
title('Initial State of Simulation')


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
title('Initial State of Simulation')


figure(3)
hold on
for j = 1:numPOI

    [path,d] = shortestpath(G,A1.currentNode,POI(j));
    costList(j) = PathCost(path,targetNode,E1);
    
    % plot each path
    pPaths(j) = PlotPath(path,E1,'red');
end

[costMin, index] = min(costList);
[path,d] = shortestpath(G,A1.currentNode,POI(index));



% plotting stuff


PlotDiscovered(E1);
PlotCellDecomp(E1);
PlotPOI(POI,E1);

pAgent = scatter(agentCoords(1),agentCoords(2),100,[0 1 0],'filled');
pTarget = scatter(targetCoord(1),targetCoord(2),100,[1 0 0],'*');


%{
% choose next node
if(length(path) == 1)
    nextNode = path(1);
else
    nextNode = path(2);
end
%}

xlabel('x axis');
ylabel('y axis');

h = zeros(4, 1);
h(1) = scatter(NaN,NaN,100,'filled','green');
h(2) = scatter(NaN,NaN,50,'*','red');
h(3) = scatter(NaN,NaN,50,'filled','red');
h(4) = plot(NaN,NaN,'red');


legend(h,'Location','northwest','Quadrotor','Target','P.O.I.','Path');

title('Evaluate Known Environment to Find Points of Interest')


%% PLOT STEP 2 - find P.O.I. and plan paths

figure(4)
hold on


costList = zeros(1,numPOI);
for j = 1:numPOI

    [path,d] = shortestpath(G,A1.currentNode,POI(j));
    costList(j) = PathCost(path,targetNode,E1);
    
    % plot each path
    pPaths(j) = PlotPath(path,E1,'red');
end

[costMin, index] = min(costList);
[path,d] = shortestpath(G,A1.currentNode,POI(index));
pPaths(j) = PlotPath(path,E1,'green');




% plotting stuff

PlotDiscovered(E1);
PlotCellDecomp(E1);
PlotPOI(POI,E1);

pTarget = scatter(targetCoord(1),targetCoord(2),100,[1 0 0],'*');
drawnow;


% choose next node
if(length(path) == 1)
    nextNode = path(1);
else
    nextNode = path(2);
end

A1.currentNode = nextNode;
agentCoords = ValToPosition(A1.currentNode,E1);
pAgent = scatter(agentCoords(1),agentCoords(2),100,[0 1 0],'filled');


h = zeros(5, 1);
h(1) = scatter(NaN,NaN,100,'filled','green');
h(2) = scatter(NaN,NaN,50,'*','red');
h(3) = scatter(NaN,NaN,50,'filled','red');
h(4) = plot(NaN,NaN,'red');
h(5) = plot(NaN,NaN,'green');

legend(h,'Location','northwest','Quadrotor','Target','P.O.I.','Path','Optimal path');


title('Select Optimal Path and Execute')

%% PLOT STEP 3 - revaluate POIs map
figure(5)
hold on

E1 = UpdateEnv(E1,A1);
% create circular list of edge nodes
circularEdgeLinkedList = GetMapEdge(E1);

% find points of interest
freeSpaceThreshold = 6;
POI = FindPointsOfInterest(circularEdgeLinkedList, freeSpaceThreshold, E1, targetNode);
numPOI = length(POI);

% find shortests paths
costList = zeros(1,numPOI);
for j = 1:numPOI

    [path,d] = shortestpath(G,A1.currentNode,POI(j));
    costList(j) = PathCost(path,targetNode,E1);
    
    % plot each path
    pPaths(j) = PlotPath(path,E1,'red');
end

[costMin, index] = min(costList);
[path,d] = shortestpath(G,A1.currentNode,POI(index));

% plotting stuff

PlotDiscovered(E1);
PlotCellDecomp(E1);
PlotPOI(POI,E1);
agentCoords = ValToPosition(A1.currentNode,E1);
pAgent = scatter(agentCoords(1),agentCoords(2),100,[0 1 0],'filled');
pTarget = scatter(targetCoord(1),targetCoord(2),100,[1 0 0],'*');
drawnow;


xlabel('x axis');
ylabel('y axis');

h = zeros(4, 1);
h(1) = scatter(NaN,NaN,100,'filled','green');
h(2) = scatter(NaN,NaN,50,'*','red');
h(3) = scatter(NaN,NaN,50,'filled','red');
h(4) = plot(NaN,NaN,'red');


legend(h,'Location','northwest','Quadrotor','Target','P.O.I.','Path');

title('Re-evaluate Known Environment to Find New Points of Interest')
