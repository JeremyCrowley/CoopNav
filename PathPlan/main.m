%% Unit tests for the cooperative navigation simulation library
close all;clc;clear;

%% Test adding objects to the environment

% % % % % % % % % % % % % % % % % % % % % % % % 
% create a 6x5 environment with 4 obstacles   %
% % % % % % % % % % % % % % % % % % % % % % % % 

length = 5;
height = 6;
E1 = CreateEnv2D(height,length);

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


%% Test add obstacle error messages

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


%% Test making a graph that corresponds with map

% % % % % % % % % % % % % % % % % % % % % % % % 
% create a 4x3 environment with 2 obstacles   %
% % % % % % % % % % % % % % % % % % % % % % % % 

length = 3;
height = 4;
E1 = CreateEnv2D(height,length);

% AddSquare2D(env, corner, length, height)
E1 = AddSquare2D(E1,[1,1],2,1);
E1 = AddSquare2D(E1,[1,2],1,2);

G = MakeGraph(E1);
PlotGraph(G.Edges, E1);


%% test creating and navigating with agent
%{
radiusOfView = 1;
startPos = [16, 15]
startNode = PositionToVal(startPos,length);

A1 = CreateAgent(radiusOfView,startNode);
E1 = UpdateEnv(E1,A1);

for i = 1:10
    A1.currentNode = PositionToVal([startPos(1)+i,startPos(2)],length);
    E1 = UpdateEnv(E1,A1);
end



PlotEnv(E1, length, height);

%}


%{
% for visualization
flipud(E1.map)

G = MakeGraph(E1.map);

% create larger lines for lower cost 
LWidths = 10*(1./G.Edges.Weight);
p = plot(G,'LineWidth',LWidths);

% create larger lines for lower cost 
%[path1,d] = shortestpath(G,1,600);
%highlight(p,path1,'EdgeColor','g');

PlotGraph(G.Edges);
%}







