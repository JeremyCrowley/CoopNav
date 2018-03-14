%% Unit tests for the cooperative navigation simulation library
close all;clc;clear;

%% Test adding objects to the environment
%{

% % % % % % % % % % % % % % % % % % % % % % % % 
% create a 6x5 environment with 4 obstacles   %
% % % % % % % % % % % % % % % % % % % % % % % % 

m = 6;
n = 5;

E1 = CreateEnv2D(m,n);

% AddSquare2D(env, corner, length, height)
E1 = AddSquare2D(E1,[1,1],3,2);
E1 = AddSquare2D(E1,[5,1],1,2);
E1 = AddSquare2D(E1,[5,6],1,1);
E1 = AddSquare2D(E1,[1,6],1,1);

% print map
fprintf('Created %dx%d environment with %d obstacles\n\n',height,length,E1.numObj);
disp('Environment map:')
disp(E1.map)

% % % % % % % % % % % % % % % % % % % % % % % % 
% Expected output                             %
% % % % % % % % % % % % % % % % % % % % % % % % 
% Created 6x5 environment with 4 obstacles    %
%                                             %
% Environment map:                            %
%      2     1     0     1     2              %
%      1     1     0     1     1              %
%      0     0     0     0     0              %
%      1     1     1     1     1              %
%      2     2     2     1     2              %
%      2     2     2     1     2              %
% % % % % % % % % % % % % % % % % % % % % % % % 

%}
%% Test add obstacle error messages
%{
% TEST 1
% E1 = AddSquare2D(E1,[7,7],2,2);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Expected Error                                                %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Error using AddSquare2D (line 9)                              %
% Error: corner (7,7) is not in the environment                 %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %


% TEST 2
% E1 = AddSquare2D(E1,[5,5],3,3);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Expected Error                                                %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Error using AddSquare2D (line 13)                             %
% Error: length 3 and height 3 are too large with corner (5,5)  %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %


% TEST 3
% E1 = AddSquare2D(E1,[4,4],2,4);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Expected Error                                                %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Error using AddSquare2D (line 17)                             %
% Error: height 2 is too large with corner (4,4)                %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %


% TEST 4
% E1 = AddSquare2D(E1,[5,5],2,2);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Expected Error                                                %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Error using AddSquare2D (line 17)                             %
% Error: length 2 is too large with corner (5,5)                %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %


% TEST 5
% E1 = AddSquare2D(E1,[1,6],1,1);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Expected Error                                                %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Error using AddSquare2D (line 28)                             %
% Error: overlapping obstacles at (1,6)                         %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

%}
%% Test making a graph that corresponds with map
%{
% % % % % % % % % % % % % % % % % % % % % % % % 
% create a 20x20 environment with 9 obstacles %
% % % % % % % % % % % % % % % % % % % % % % % % 

length = 20;
height = 20;
E1 = CreateEnv2D(height,length);

% AddSquare2D(env, corner, length, height)
E1 = AddSquare2D(E1,[1,1],2,1);
E1 = AddSquare2D(E1,[10,1],2,5);
E1 = AddSquare2D(E1,[5,5],5,2);
E1 = AddSquare2D(E1,[8,11],2,2);
E1 = AddSquare2D(E1,[11,6],2,6);
E1 = AddSquare2D(E1,[9,15],5,2);
E1 = AddSquare2D(E1,[3,10],2,8);
E1 = AddSquare2D(E1,[15,3],3,4);
E1 = AddSquare2D(E1,[17,13],2,6);


G = MakeGraph(E1);
figure(1)
PlotGraph(G.Edges, E1);

%}
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
radiusOfView = 1;
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
path = zeros(2,numPOI);
d = zeros(1,numPOI);
for i = 1:numPOI
    [path(:,i),d(i)] = shortestpath(G,A1.currentNode,POI(i));
end


fprintf('%d points of interest found:\n\n',numPOI);
fprintf('Node %d with shortest path %d --> %d\n',POI(1),path(1,1),path(2,1));
fprintf('Node %d with shortest path %d --> %d\n',POI(2),path(1,2),path(2,2));
fprintf('Node %d with shortest path %d --> %d\n',POI(3),path(1,3),path(2,3));
fprintf('Node %d with shortest path %d --> %d\n',POI(4),path(1,4),path(2,4));


% % % % % % % % % % % % % % % % % % % % % % % % 
% Expected output                             %
% % % % % % % % % % % % % % % % % % % % % % % % 
% 4 points of interest found:                 %
%                                             %
% Node 9 with shortest path 17 --> 9          %
% Node 11 with shortest path 17 --> 11        %
% Node 25 with shortest path 17 --> 25        %
% Node 23 with shortest path 17 --> 23        %
% % % % % % % % % % % % % % % % % % % % % % % %

%}



%% Visualization and djikstra
%{
% for visualization
figure(2)
% create larger lines for lower cost 

LWidths = 10*(1./G.Edges.Weight);
p = plot(G,'LineWidth',LWidths);

% create larger lines for lower cost 
[path1,d] = shortestpath(G,3,20);
highlight(p,path1,'EdgeColor','g');
%}










