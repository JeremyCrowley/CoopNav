% cell decomposition
close all;clc;clear;


length = 25;
height = 25;
E1 = CreateEnv2D(length,height);

% env, corner, length, height
E1 = AddSquare2D(E1,[2,3],2,1);
E1 = AddSquare2D(E1,[7,2],5,6);

E1 = AddSquare2D(E1,[5,15],5,3);
%E1 = AddSquare2D(E1,[16,5],2,4);
%E1 = AddSquare2D(E1,[10,15],3,7);
%E1 = AddSquare2D(E1,[20,12],9,4);

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

%{
for i = 1:length
    for j = 1:height
        hold on
        scatter(i,j,'color',[0 0 0]);
        hold on
    end
end
%}


