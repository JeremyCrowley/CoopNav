close all;
clc;
clear;

m = 16;
n = 16;
numIterations = m-2;



% how to add objects: 
% env = AddSquare2D(env, corner, length, height)

%% Environment 1
f1 = figure()
E1 = CreateEnv2D(m,n);
E1 = AddSquare2D(E1,[3,3],7,2);
E1 = AddSquare2D(E1,[3,10],7,5);
E1 = AddSquare2D(E1,[10,1],4,14);
PlotCellDecomp(E1);


%% Environment 2
f2 = figure()
E2 = CreateEnv2D(m,n);
E2 = AddSquare2D(E2,[3,4],7,3);
E2 = AddSquare2D(E2,[14,1],1,14);
E2 = AddSquare2D(E2,[7,7],3,8);
E2 = AddSquare2D(E2,[10,7],4,3);
PlotCellDecomp(E2);


%% Environment 3
f3 = figure()
E3 = CreateEnv2D(m,n);
E3 = AddSquare2D(E3,[3,3],2,10);
E3 = AddSquare2D(E3,[1,10],2,4);
E3 = AddSquare2D(E3,[8,5],2,4);
E3 = AddSquare2D(E3,[8,9],9,2);
PlotCellDecomp(E3);


%% Environment 4
f4 = figure()
E4 = CreateEnv2D(m,n);
E4 = AddSquare2D(E4,[6,8],11,2);
PlotCellDecomp(E4);


%% Environment 5
f5 = figure()
E5 = CreateEnv2D(m,n);
E5 = AddSquare2D(E5,[10,6],3,11);
E5 = AddSquare2D(E5,[3,5],3,2);
E5 = AddSquare2D(E5,[6,1],1,6);
PlotCellDecomp(E5);



%% Environment 6
f6 = figure()
E6 = CreateEnv2D(m,n);
E6 = AddSquare2D(E6,[5,9],10,3);
E6 = AddSquare2D(E6,[15,6],2,5);
E6 = AddSquare2D(E6,[8,4],9,2);
PlotCellDecomp(E6);


%% Environment 7
f7 = figure()
E7 = CreateEnv2D(m,n);
E7 = AddSquare2D(E7,[5,10],5,7);
E7 = AddSquare2D(E7,[5,4],1,6);
E7 = AddSquare2D(E7,[10,9],2,8);
PlotCellDecomp(E7);


%% Environment 8
f8 = figure()
E8 = CreateEnv2D(m,n);
E8 = AddSquare2D(E8,[8,3],2,6);
E8 = AddSquare2D(E8,[10,6],7,3);
E8 = AddSquare2D(E8,[4,12],13,2);
PlotCellDecomp(E8);


%% Environment 9
f9 = figure()
E9 = CreateEnv2D(m,n);
E9 = AddSquare2D(E9,[8,3],5,1);
E9 = AddSquare2D(E9,[3,4],1,7);
E9 = AddSquare2D(E9,[13,1],4,8);
E9 = AddSquare2D(E9,[4,9],13,1);
PlotCellDecomp(E9);


%% Environment 10
f10 = figure()
E10 = CreateEnv2D(m,n);
E10 = AddSquare2D(E10,[4,4],2,2);
E10 = AddSquare2D(E10,[11,1],6,8);
E10 = AddSquare2D(E10,[3,9],14,1);
E10 = AddSquare2D(E10,[9,10],8,3);
PlotCellDecomp(E10);




pause(10)

%% simulate - 
tic

timeTaken = zeros(10,numIterations);
timeTaken(1,:) = SimEnv(E1);
timeTaken(2,:) = SimEnv(E2);
timeTaken(3,:) = SimEnv(E3);
timeTaken(4,:) = SimEnv(E4);
timeTaken(5,:) = SimEnv(E5);
timeTaken(6,:) = SimEnv(E6);
timeTaken(7,:) = SimEnv(E7);
timeTaken(8,:) = SimEnv(E8);
timeTaken(9,:) = SimEnv(E9);
timeTaken(10,:) = SimEnv(E10);

%% plot

figure()
for i = 1:10
    plot([3:1:m],timeTaken(i,:));
    hold on
end

ymax = round(max(max(timeTaken)))+5;


axis([3 m 0 ymax])
xlabel('Radius of View');
ylabel('Time taken to reach target');

title({'Complex Environments','Time taken to reach target vs. radius of view'})


toc


%% save

saveas(f1,'ComplexEnv1.epsc')
saveas(f2,'ComplexEnv2.epsc')
saveas(f3,'ComplexEnv3.epsc')
saveas(f4,'ComplexEnv4.epsc')
saveas(f5,'ComplexEnv5.epsc')
saveas(f6,'ComplexEnv6.epsc')
saveas(f7,'ComplexEnv7.epsc')
saveas(f8,'ComplexEnv8.epsc')
saveas(f9,'ComplexEnv9.epsc')
saveas(f10,'ComplexEnv10.epsc')


