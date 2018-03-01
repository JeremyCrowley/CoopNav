% cell decomposition
close all;clc;clear;



E1 = CreateEnv2D(25,25);

% env, corner, length, height
E1 = AddSquare2D(E1,[2,3],2,1);
E1 = AddSquare2D(E1,[7,2],5,6);
E1 = AddSquare2D(E1,[5,2],5,1);
E1 = AddSquare2D(E1,[5,15],5,3);
E1 = AddSquare2D(E1,[16,5],2,4);
E1 = AddSquare2D(E1,[10,15],3,7);
E1 = AddSquare2D(E1,[20,12],9,4);

% for visualization
flipud(E1.map)

G = MakeGraph(E1.map);

% create larger lines for lower cost 
LWidths = 10*(1./G.Edges.Weight);
p = plot(G,'LineWidth',LWidths);

[path1,d] = shortestpath(G,1,600);
highlight(p,path1,'EdgeColor','g');

PlotGraph(G.Edges);


