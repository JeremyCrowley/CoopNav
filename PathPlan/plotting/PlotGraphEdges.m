% p = PlotGraphEdges(graphEdges)

function p = PlotGraphEdges(graphEdges)

    [edgeHeight,edgeLength] = size(graphEdges);

    % draw arrows for directional graph edges
    for i = 1:edgeHeight
        
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

        
        % to show cost of path
        quiver(tail(1),tail(2),vector(1),vector(2),0,'color',color);


    end
end

