

function [nextCoord, circularEdgeLinkedList, POI] = PathPlan(environment,G,agent,targetNode)

        % create circular list of edge nodes
        circularEdgeLinkedList = GetMapEdge(environment);

        % find points of interest
        freeSpaceThreshold = 4;
        POI = FindPointsOfInterest(circularEdgeLinkedList, freeSpaceThreshold, environment, targetNode);



        numPOI = length(POI);

        % find shortests paths

        costList = zeros(1,numPOI);
        for j = 1:numPOI

            [path,d] = shortestpath(G,agent.currentNode,POI(j));
            costList(j) = PathCost(path,targetNode,environment);
        end

        [costMin, index] = min(costList);
        [path,d] = shortestpath(G,agent.currentNode,POI(index));


        

        % choose next node
        if(length(path) == 1)
            nextNode = path(1);
        else
            nextNode = path(2);
        end

        % trace agents trajectory
        c1 = ValToPosition(agent.currentNode,environment);
        c2 = ValToPosition(nextNode,environment);
        plot([c1(1),c2(1)],[c1(2),c2(2)],'green','LineWidth',3);
        
        nextCoord = c2;
end