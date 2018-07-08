% test file to run the simulation function


close all;
clc;
clear;

m = 7;
n = 7;

E1 = CreateEnv2D(m,n);
E1 = AddSquare2D(E1,[2,4],1,1);
E1 = AddSquare2D(E1,[6,5],1,1);
G = MakeGraph(E1);

radiusOfView = 3;
startCoord = [1, 1];
targetCoord = [7,7];
dispPOI = 0;


simulate(E1,G,startCoord,targetCoord,radiusOfView,dispPOI)



