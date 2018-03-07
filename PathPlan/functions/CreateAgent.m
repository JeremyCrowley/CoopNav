% 
function agent = CreateAgent(radiusOfView, startNode)
    
    agent.radiusOfView = radiusOfView;
    agent.currentNode = startNode;
    agent.discoveredNodes = [startNode];
    
    

end