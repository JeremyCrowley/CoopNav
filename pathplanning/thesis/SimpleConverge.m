
m = 10;
n = m;
numObjs = 5;
iterations = 10;
timeTaken = zeros(iterations,m-3);
figure()
for i = 1:iterations
	timeTaken(i,1:m-3) = SimRandomEnv(m,n,numObjs);
    plot((3:1:m-1),timeTaken(i,1:m-3))
    hold on
end

ymax = round(max(max(timeTaken)))+5;


axis([3 m-1 0 ymax])
xlabel('Radius of View');
ylabel('Time taken to reach target');

%title({'Simple Environments','Time taken to reach target vs. radius of view'})