% p = PlotGraph(GraphEdges)
% 
% plots the graph with colored edges based on the weight of the edge
%
% GraphEdges - the edges of the graph

function [pCell, pDiscovered, pPOI, pAgent] = PlotGraph(graphEdges,circularEdgeLinkedList,POI,env,agent,pCellOld,pDiscoveredOld, pPOIOld, pAgentOld)

    hold on
    grid on
    
    
    delete(pDiscoveredOld);
    delete(pPOIOld);
    delete(pAgentOld);
    delete(pCellOld);

    
    %PlotGraphEdges(graphEdges);
    
    pCell = PlotCellDecomp(env);

    
    %PlotDiscoveredEdge(circularEdgeLinkedList)
    pDiscovered = PlotDiscovered(env);
    
    pPOI = PlotPOI(POI,env);
    set(pPOI,'Visible','on')
     
    % plot location of agent
    agentCoords = ValToPosition(agent.currentNode,env);
    pAgent = scatter(agentCoords(1),agentCoords(2),50,[0 1 0],'*');
   
end