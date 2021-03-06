close all;
clc;
clear;

m = 16;
n = 16;
numIterations = m-3;

% set sim params
startCoord = [1, 1];
targetCoord = [m, n];
dispPOI = 0;


% how to add objects: 
% env = AddSquare2D(env, corner, length, height)

%% Environment 1
figure()
E1 = CreateEnv2D(m,n);
E1 = AddSquare2D(E1,[3,3],7,2);
E1 = AddSquare2D(E1,[3,10],7,5);
E1 = AddSquare2D(E1,[10,1],4,14);
PlotCellDecomp(E1);

%% Env 1 plot
G = MakeGraph(E1);
f = figure();
subplot(2,2,1)
[iterations,pDiscovered,pPOI,pAgent,pCell,pPath,agentPath,distanceToTarget,timeline] = simulate(E1,G,startCoord,targetCoord,5,dispPOI);
title('r = 5')
subplot(2,2,2)
[iterations,pDiscovered,pPOI,pAgent,pCell,pPath,agentPath,distanceToTarget,timeline] = simulate(E1,G,startCoord,targetCoord,7,dispPOI);
title('r = 7')
subplot(2,2,3)
[iterations,pDiscovered,pPOI,pAgent,pCell,pPath,agentPath,distanceToTarget,timeline] = simulate(E1,G,startCoord,targetCoord,8,dispPOI);
title('r = 8')
subplot(2,2,4)
[iterations,pDiscovered,pPOI,pAgent,pCell,pPath,agentPath,distanceToTarget,timeline] = simulate(E1,G,startCoord,targetCoord,16,dispPOI);
title('r = 16')




%% env 2

figure()
E2 = CreateEnv2D(m,n);


E2 = AddSquare2D(E2,[3,11],9,4);
E2 = AddSquare2D(E2,[12,1],3,14);
PlotCellDecomp(E2);

%%

G = MakeGraph(E2);
f = figure();
subplot(2,2,1)
[iterations,pDiscovered,pPOI,pAgent,pCell,pPath,agentPath,distanceToTarget,timeline] = simulate(E2,G,startCoord,targetCoord,5,dispPOI);
title('r = 5')
subplot(2,2,2)
[iterations,pDiscovered,pPOI,pAgent,pCell,pPath,agentPath,distanceToTarget,timeline] = simulate(E2,G,startCoord,targetCoord,9,dispPOI);
title('r = 9')
subplot(2,2,3)
[iterations,pDiscovered,pPOI,pAgent,pCell,pPath,agentPath,distanceToTarget,timeline] = simulate(E2,G,startCoord,targetCoord,10,dispPOI);
title('r = 10')
subplot(2,2,4)
[iterations,pDiscovered,pPOI,pAgent,pCell,pPath,agentPath,distanceToTarget,timeline] = simulate(E2,G,startCoord,targetCoord,16,dispPOI);
title('r = 16')



%% converge

timeTaken1 = SimEnv(E1);
timeTaken2 = SimEnv(E2);



%% plot
figure()
ymax1 = round(max(timeTaken1))+5;
ymax2 = round(max(timeTaken2))+5;
ymax = max([ymax1 ymax2]);

subplot(2,1,1)
plot([3:1:m],timeTaken1);
hold on
plot([3 m],[timeTaken1(end) timeTaken1(end)],'--')
title('Complex Environment 1')
axis([3 m 0 ymax])
xlabel('Radius of View');
ylabel('Time taken to reach target');
legend('Time to reach target','Minimum time to reach target')

subplot(2,1,2)
plot([3:1:m],timeTaken2);
hold on
plot([3 m],[timeTaken2(end) timeTaken2(end)],'--')
title('Complex Environment 2')
axis([3 m 0 ymax])
xlabel('Radius of View');
ylabel('Time taken to reach target');





