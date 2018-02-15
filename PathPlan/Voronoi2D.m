close all;clear;clc;


%% 2D example
%x = gallery('uniformdata',[1 10],0)
%y = gallery('uniformdata',[1 10],1)
%voronoi(x,y)



%% 2D example
%{
X = [0.5 0; 0 0.5; -0.5 -0.5; -0.2 -0.1; -0.1 0.1; 0.1 -0.1; 0.1 0.1]
[V,C] = voronoin(X)

plot(V(:,1),V(:,2),'r')
hold on
%plot(C(:,1),C(:,2),'r')
scatter(X(:,1),X(:,2),'b')
%}


%% main


E1 = CreateEnv2D(20,20);


for i = 1:4
    for j = 1:4 
        E1 = AddObj2D(E1,[1+4*j, 1+4*i],3,3);
        
    end
end

center = zeros(E1.numObj,2);
for i = 1:E1.numObj
    
    center(i,:) = FindCenter2D(E1.objs(:,:,i));
   
    MakeObj2D(E1.objs(:,:,i));
    
end

xlim([0 20]);
ylim([0 20]);


E1.objs
%{
[V,C] = voronoin(center);

hold on

for i = 1:length(C) 
    if all(C{i}~=1)   % If at least one of the indices is 1, 
                      % then it is an open region and we can't 
                      % patch that.
        patch(V(C{i},1),V(C{i},2),i); % use color i.
    end
end


for i = 1:E1.numObj
    %scatter(E1.objs(:,1,i), E1.objs(:,2,i));
    scatter(center(:,1,i), center(:,2,i));
    hold on
end

%scatter(V(:,1),V(:,2),'r')
%}


