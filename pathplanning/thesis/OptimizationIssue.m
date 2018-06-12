close all;
clc;
clear;

m = 15;
n = 15;

% set sim params
startCoord = [1, 8];
targetCoord = [m, 8];
radiusOfView = 3;
dispPOI = 0;

% create environment
E = CreateEnv2D(m,n);
E = AddSquare2D(E,[3,3],4,11);

% create graph
G = MakeGraph(E);

% simulate
f = figure();
[iterations,pDiscovered,pPOI,pAgent,pCell,pPath,agentPath,distanceToTarget,timeline] = simulate(E,G,startCoord,targetCoord,radiusOfView,dispPOI);