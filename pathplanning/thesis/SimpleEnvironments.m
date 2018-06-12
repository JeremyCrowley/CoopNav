

close all;
clc;
clear;

m = 10;
n = 10;

numIterations = m-3;


% how to add objects: 
% env = AddSquare2D(env, corner, length, height)

%% Environment 1

E1 = CreateEnv2D(m,n);
E1 = AddSquare2D(E1,[1,3],1,2);
E1 = AddSquare2D(E1,[3,8],1,2);
E1 = AddSquare2D(E1,[5,3],2,1);
E1 = AddSquare2D(E1,[6,4],1,1);
E1 = AddSquare2D(E1,[7,8],2,1);




G = MakeGraph(E1);


startCoord = [1, 1];
targetCoord = [m, n];
dispPOI = 0;

i = 3;

timeTaken1 = zeros(1,numIterations);
while(i < m)
    radiusOfView = i;
    
    f = figure();
    [iterations,pDiscovered,pPOI,pAgent,pCell,pPath,agentPath,distanceToTarget,timeline] = simulate(E1,G,startCoord,targetCoord,radiusOfView,dispPOI)
    close(f)
    
    figure(100)
    [dm, dn] = size(distanceToTarget);
    plot(timeline,distanceToTarget)
    hold on
    
    timeTaken1(i-2) = timeline(end);
    
    i = i + 1;
end

figure(200)
plot([3:1:m-1],timeTaken1);
title('Simple Environment 1 - Time to reach target vs. Radius of view')
xlabel('Radius of view')
ylabel('Time to reach target')

%% Environment 2
figure()
E2 = CreateEnv2D(m,n);
E2 = AddSquare2D(E2,[1,3],1,1);
E2 = AddSquare2D(E2,[5,4],1,1);
E2 = AddSquare2D(E2,[9,8],2,1);
E2 = AddSquare2D(E2,[5,8],1,1);



G = MakeGraph(E2);

radiusOfView = 3;
startCoord = [1, 1];
targetCoord = [m,n];
dispPOI = 0;

i = 3;
timeTaken2 = zeros(1,numIterations);
while(i < m)
    radiusOfView = i;
    
    f = figure();
    [iterations,pDiscovered,pPOI,pAgent,pCell,pPath,agentPath,distanceToTarget,timeline] = simulate(E2,G,startCoord,targetCoord,radiusOfView,dispPOI)
    close(f)
    
    figure(101)
    [dm, dn] = size(distanceToTarget);
    plot(timeline,distanceToTarget)
    hold on
    
    timeTaken2(i-2) = timeline(end);
    
    i = i + 1;
end

figure(201)
plot([3:1:m-1],timeTaken2);
title('Simple Environment 2 - Time to reach target vs. Radius of view')
xlabel('Radius of view')
ylabel('Time to reach target')

%% Environment 3
figure()
E3 = CreateEnv2D(m,n);
E3 = AddSquare2D(E3,[1,3],2,2);
E3 = AddSquare2D(E3,[7,5],2,1);
E3 = AddSquare2D(E3,[8,10],1,1);

G = MakeGraph(E3);

radiusOfView = 3;
startCoord = [1, 1];
targetCoord = [m,n];
dispPOI = 0;

i = 3;
timeTaken3 = zeros(1,numIterations);
while(i < m)
    radiusOfView = i;
    
    f = figure();
    [iterations,pDiscovered,pPOI,pAgent,pCell,pPath,agentPath,distanceToTarget,timeline] = simulate(E3,G,startCoord,targetCoord,radiusOfView,dispPOI)
    close(f)
    
    figure(102)
    [dm, dn] = size(distanceToTarget);
    plot(timeline,distanceToTarget)
    hold on
    
    timeTaken3(i-2) = timeline(end);
    
    i = i + 1;
end

figure(202)
plot([3:1:m-1],timeTaken3);

title('Simple Environment 3 - Time to reach target vs. Radius of view')
xlabel('Radius of view')
ylabel('Time to reach target')


%% axes legends etc

figure(100)
title('Simple Environment 1')
xlabel('Time (s)')
ylabel('Distance to Target (m)')


figure(101)
title('Simple Environment 2')
xlabel('Time (s)')
ylabel('Distance to Target (m)')

figure(102)
title('Simple Environment 3')
xlabel('Time (s)')
ylabel('Distance to Target (m)')



