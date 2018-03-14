% p = PlotGraph(GraphEdges)
% 
% plots the graph with colored edges based on the weight of the edge
%
% GraphEdges - the edges of the graph

function p = PlotGraph(graphEdges,env)

    [height,length] = size(graphEdges);
    
    hold on
    grid on
    
    for i = 1:height
        
        % parse end nodes
        endNodeCell1 = graphEdges.EndNodes(i,1);
        endNodeCell2 = graphEdges.EndNodes(i,2);
        
        endNode1 = endNodeCell1{1};
        endNode2 = endNodeCell2{1};
        
        comma1 = strfind(endNode1,',');
        par1 = strfind(endNode1,')');
        comma2 = strfind(endNode2,',');
        par2 = strfind(endNode2,')');
        
        x1 = str2num(endNode1(2:comma1));
        y1 = str2num(endNode1(comma1+1:par1-1));
        x2 = str2num(endNode2(2:comma2));
        y2 = str2num(endNode2(comma2+1:par2-1));
        
        
        
        % vector to display direction of motion into a region
        tail = [(x2-x1)/2+x1, (y2-y1)/2+y1];
        vector = [0.9*(tail(1)-x1), 0.9*(tail(2)-y1)];

        
        if(table2array(graphEdges(i,2)) == 1000)
            color = [1 0 0];
        elseif(table2array(graphEdges(i,2)) == 2 || table2array(graphEdges(i,2)) == sqrt(8))
            color = [0 0 1];
        else
            color = [0 1 0];
        end
        
        %p = plot([coord1(1),coord2(1)],[coord1(2),coord2(2)],'color',color);
        
        % to show cost of path
        %quiver(tail(1),tail(2),vector(1),vector(2),0,'color',color);


    end
    
    [height,length] = size(env.map);
    
    for i = 1:length
        for j = 1:height
            %scatter(i,j,100,[0 0 0],'filled');
            
            arrIndex = CoordToArray([i,j],env);
            if(env.map(arrIndex(1),arrIndex(2)) == 2)
                color = 'red';
            elseif(env.map(arrIndex(1),arrIndex(2)) == 1)
                color = 'blue';
            else
                color = 'green';
            end
            PlotObstacleSquare([i,j],color,0.15);
            
            
            
            if(env.node(arrIndex(1),arrIndex(2)).discovered == 0)
                color = [0 0 0];
            elseif(env.node(arrIndex(1),arrIndex(2)).edge == 1)
                color = [0 1 0];
            else
                color = [1 0 0];
            end
            
            
            val = PositionToVal([i,j], env);
            
            scatter(i,j,10,color);
            
            annot = sprintf('%d',val);
            text(i,j,annot)
            
        end
    end
    
    
        
    
    xlim([0 length+1]);
    ylim([0 height+1]);

end