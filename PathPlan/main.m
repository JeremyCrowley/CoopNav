% cell decomposition
close all;clc;clear;

length = 5;
height = 5;
E1 = CreateEnv2D(length,height);

% env, corner, length, height
E1 = AddSquare2D(E1,[2,3],2,1);
%E1 = AddSquare2D(E1,[7,2],5,6);

%E1 = AddSquare2D(E1,[5,15],5,3);


radiusOfView = 1;
startNode = PositionToVal([5,4],length)

A1 = CreateAgent(radiusOfView,startNode);
%{
E1 = UpdateEnv(E1,A1);
PlotEnv(E1, length, height);
A1.currentNode = PositionToVal([3,4],length);
E1 = UpdateEnv(E1,A1);
PlotEnv(E1, length, height);
A1.currentNode = PositionToVal([4,4],length);
E1 = UpdateEnv(E1,A1);
PlotEnv(E1, length, height);
%}

E1 = UpdateEnv(E1,A1);
PlotEnv(E1, length, height);


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







