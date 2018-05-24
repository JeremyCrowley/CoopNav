clear;clc;close all;


m = 2;
n = 3;

E1 = CreateEnv2D(m,n);

G = MakeGraph(E1);

plot(G)

title('Directed Graph Representation of Environment')
