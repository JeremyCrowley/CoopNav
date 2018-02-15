% cell decomposition
close all;clc;clear;

E1 = CreateEnv2D(7,6);


%{
for i = 1:4
    for j = 1:4 
        E1 = AddSquare2D(E1,[1+4*j, 1+4*i],3,3);     
    end
end


center = zeros(E1.numObj,2);
for i = 1:E1.numObj
    
    center(i,:) = FindCenter2D(E1.objs(:,:,i));
   
    MakeObj2D(E1.objs(:,:,i));
    
end
%}


flipud(E1.map);

G = MakeGraph(E1.map);


plot(G)

%xlim([0 20]);
%ylim([0 20]);

