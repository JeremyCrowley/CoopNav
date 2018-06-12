

m = 15;
n = m;

E = CreateEnv2D(m,n);

E = CellDecomposeObject(1.1, 0.9, [0.71 0.51], 0.22, 0.32, E);
E = CellDecomposeObject(1.1, 0.9, [0.19 0.54], 0.095, 0.35, E);

PlotCellDecomp(E);

G = MakeGraph(E);

startCoord = [1, n];
targetCoord = [m, n];
radiusOfView = 3;
dispPOI = 0;

figure()
simulate(E,G,startCoord,targetCoord,radiusOfView,1);