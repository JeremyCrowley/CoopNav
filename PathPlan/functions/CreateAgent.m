% agent = CreateAgent(radiusOfView, startNode)
%
% creates an agent struct
%
% radiusOfView - the radius of view around the agent
% startNode    - starting node for simulations
%

function agent = CreateAgent(radiusOfView, startNode)
    
    agent.radiusOfView = radiusOfView;
    agent.currentNode = startNode;

end