% p = PlotGraph(GraphEdges)
function p = PlotGraph(GraphEdges)

    [m,n] = size(GraphEdges);
    
    figure()
    hold on
    grid on
    for i = 1:m
        
        % parse end nodes
        endNodeCell1 = GraphEdges.EndNodes(i,1);
        endNodeCell2 = GraphEdges.EndNodes(i,2);
        
        endNode1 = endNodeCell1{1}
        endNode2 = endNodeCell2{1}
        
        comma1 = strfind(endNode1,',');
        par1 = strfind(endNode1,')');
        comma2 = strfind(endNode2,',');
        par2 = strfind(endNode2,')');
        
        x1 = str2num(endNode1(2:comma1));
        y1 = str2num(endNode1(comma1+1:par1-1));
        x2 = str2num(endNode2(2:comma2));
        y2 = str2num(endNode2(comma2+1:par2-1));
        
        coord1 = [x1, y1];
        coord2 = [x2, y2];
        
        if(table2array(GraphEdges(i,2)) == 1000)
            color = 'r';
        elseif(table2array(GraphEdges(i,2)) >= 2)
            color = 'b';
        else
            color = 'g';
        end
        
        p = plot([coord1(1),coord2(1)],[coord1(2),coord2(2)],color);
        
        hold on
    end

end