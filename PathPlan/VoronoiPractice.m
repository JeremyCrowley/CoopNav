%x = gallery('uniformdata',[1 10],0)
%y = gallery('uniformdata',[1 10],1)
%voronoi(x,y)

close all;clear;clc;





E1 = CreateEnv(20,20,20);

for i = 1:3
    E1 = AddObj(E1,[1,1,i*5],2,2,3);
    E1 = AddObj(E1,[1,5,i*5],2,2,3);
    E1 = AddObj(E1,[1,10,i*5],2,2,3);
    E1 = AddObj(E1,[1,15,i*5],2,2,3);
    E1 = AddObj(E1,[5,1,i*5],2,2,3);
    E1 = AddObj(E1,[10,1,i*5],2,2,3);
    E1 = AddObj(E1,[15,1,i*5],2,2,3);

    E1 = AddObj(E1,[5,5,i*5],2,2,3);
    E1 = AddObj(E1,[10,10,i*5],2,2,3);
    E1 = AddObj(E1,[15,15,i*5],2,2,3);

    E1 = AddObj(E1,[10,5,i*5],2,2,3);
    E1 = AddObj(E1,[5,10,i*5],2,2,3);
    E1 = AddObj(E1,[15,10,i*5],2,2,3);
    E1 = AddObj(E1,[10,15,i*5],2,2,3);
    E1 = AddObj(E1,[15,5,i*5],2,2,3);
    E1 = AddObj(E1,[5,15,i*5],2,2,3);
end

E1.map;
E1.objs

center = zeros(E1.numObj,3);
for i = 1:E1.numObj
    
    center(i,:) = FindCenter(E1.objs(:,:,i));
    
    %E1.objs(:,:,i)
    MakeObj(E1.objs(:,:,i));
    
end

xlim([0 20]);
ylim([0 20]);
zlim([0 20]);

[V,C] = voronoin(center)

hold on

plot3(V(:,1),V(:,2),V(:,3),'r')


function env = CreateEnv(length,width,height)
    env.map = zeros(length,width,height);
    env.objs = [];
    env.numObj = 0;
    
end

function env = AddObj(environment,corner,length,width,height)
    
    environment.map(corner(1):corner(1)+length-1,corner(2):corner(2)+width-1,corner(3):corner(3)+height-1) = ones(length,width,height);
    
    v1 = corner;
    
    v2 = [corner(1)+length-1    ,corner(2)          ,corner(3)];
    v3 = [corner(1)             ,corner(2)+width-1  ,corner(3)];
    v4 = [corner(1)             ,corner(2)          ,corner(3)+height-1];
    
    v5 = [corner(1)+length-1    ,corner(2)+width-1  ,corner(3)];
    v6 = [corner(1)             ,corner(2)+width-1  ,corner(3)+height-1];
    v7 = [corner(1)+length-1    ,corner(2)          ,corner(3)+height-1];
    
    v8 = [corner(1)+length-1    ,corner(2)+width-1  ,corner(3)+height-1];
    
    if(environment.numObj == 0)
        environment.objs(:,:,1) = [v1;v2;v3;v4;v5;v6;v7;v8];
    else
        environment.objs(:,:,end+1) = [v1;v2;v3;v4;v5;v6;v7;v8];
    end
        
    environment.numObj = environment.numObj+1; 
    
    env = environment;
end

function center = FindCenter(obj)
    center = (obj(8,:)-obj(1,:)+1)/2 + obj(1,:);
end


