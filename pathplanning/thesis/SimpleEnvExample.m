
%% plot environment
figure()

m = 10;
n = m;

E = CreateEnv2D(m,n);
E = AddSquare2D(E,[3,4],1,1);
E = AddSquare2D(E,[7,3],1,1);
E = AddSquare2D(E,[8,7],1,1);
E = AddSquare2D(E,[4,7],1,1);
E = AddSquare2D(E,[4,8],1,1);

PlotCellDecomp(E);

title('Simple Environment example')
xlabel('x axis')
ylabel('y axis')


%% Simulate

% create digraph
G = MakeGraph(E);

% set sim params
startCoord = [1, 1];
targetCoord = [m, n];
dispPOI = 0;
numIterations = m-3;
i = 3;
timeTaken = zeros(1,numIterations);
while(i < m)
    radiusOfView = i;

    % simulate
    f = figure();
    [iterations,pDiscovered,pPOI,pAgent,pCell,pPath,agentPath,distanceToTarget,timeline] = simulate(E,G,startCoord,targetCoord,radiusOfView,dispPOI);
    %close(f)

    % overlay time distance to target v time
    %figure(100)
    %[dm, dn] = size(distanceToTarget);
    %plot(timeline,distanceToTarget)
    %hold on

    timeTaken(i-2) = timeline(end);

    i = i + 1;
end

ymax = round(max(max(timeTaken)))+5;
figure()
plot((3:1:m-1),timeTaken)
axis([3 m-1 0 ymax])
title({'Simple Environment Example','Time taken to reach target vs. radius of view'})
xlabel('Radius of View');
ylabel('Time taken to reach target');

