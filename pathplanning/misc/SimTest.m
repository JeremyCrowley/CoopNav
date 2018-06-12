
close all;
clc;
clear;


%m = 14;
%n = 14;
m = 7;
n = 7;

E1 = CreateEnv2D(m,n);
E1 = AddSquare2D(E1,[2,4],1,1);
E1 = AddSquare2D(E1,[6,5],1,1);
G = MakeGraph(E1);

% AddSquare2D(env, corner, length, height)

% 14x14
%E1 = AddSquare2D(E1,[3,9],5,1);
%E1 = AddSquare2D(E1,[3,4],5,1);
%E1 = AddSquare2D(E1,[8,1],3,4);
%E1 = AddSquare2D(E1,[8,5],1,8);
%E1 = AddSquare2D(E1,[12,1],2,7);
%E1 = AddSquare2D(E1,[12,11],1,4);

radiusOfView = 3;
startCoord = [1, 1];
targetCoord = [7,7];
dispPOI = 0;


simulate(E1,G,startCoord,targetCoord,radiusOfView,dispPOI)



