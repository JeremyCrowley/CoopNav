% p = PlotDiscoveredEdge(circularEdgeLinkedList)

function p = PlotDiscoveredEdge(circularEdgeLinkedList,env)

% show edge of discovered map
    [circHeight, circLength] = size(circularEdgeLinkedList.node);
    
    for i = 1:circLength
        
        c1 =  ValToPosition(circularEdgeLinkedList.node(i).nodeNum,env);
        
        if(i == circLength)
            c2 =  ValToPosition(circularEdgeLinkedList.node(1).nodeNum,env);
        else
            c2 =  ValToPosition(circularEdgeLinkedList.node(i+1).nodeNum,env);
        end
        
        
        
        p(i) = plot([c1(1),c2(1)],[c1(2),c2(2)],'color',[0 0 0],'LineWidth',3);
        
    end
end