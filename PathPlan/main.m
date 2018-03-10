%% Unit tests for the cooperative navigation simulation library
close all;clc;clear;

%% test adding objects to the environment
length = 5;
height = 6;
E1 = CreateEnv2D(height,length);

E1.map

% env, corner, length, height
E1 = AddSquare2D(E1,[1,1],3,2);
E1 = AddSquare2D(E1,[5,1],1,2);

E1 = AddSquare2D(E1,[5,6],1,1);
E1 = AddSquare2D(E1,[1,6],1,1);
%E1 = AddSquare2D(E1,[5,1],2,2);
%E1 = AddSquare2D(E1,[1,1],2,1);
%E1 = AddSquare2D(E1,[3,5],2,2);

% should throw an error of overlapping objects
% E1 = AddSquare2D(E1,[5,5],2,2);
% E1 = AddSquare2D(E1,[4,4],2,2);
E1.map

%{
G = MakeGraph(E1.map);
PlotGraph(G.Edges, E1);
%}

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







