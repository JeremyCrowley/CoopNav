% nextEdgeNodeVal = GetNextEdgeNode(curEdgeNodeVal,adjEdgeVal,lastMove) 
%
% returns the next edge node in the discovered edge, this is used in the
% pattern based point of interest detection algorithm

function [nextNode, dir] = GetNextEdgeNode(curEdgeNodeVal,adjEdgeVal,lastMove, env) 
    
    curEdgeCoords = ValToPosition(curEdgeNodeVal, env);
    
    numAdjEdges = length(adjEdgeVal);
    
    adjDir = zeros(1,2);
    adjCoord = zeros(2,2);
    
    
    
    % find direction of adj nodes
    for i = 1:numAdjEdges
        
        adjCoord(:,i) = ValToPosition(adjEdgeVal(i).val,env);
        
        xDiff = curEdgeCoords(1)-adjCoord(1,i);
        yDiff = curEdgeCoords(2)-adjCoord(2,i);
        
        if(xDiff == 0 && yDiff == 0)
            error('Error: adj node is cur node');
        end
        
        if(xDiff ~= 0 && yDiff ~= 0)
            error('Error: adj node is diagonal from cur node');
        end
        
        if(xDiff == -1 && yDiff == 0)
            adjDir(i) = 1;
        elseif(xDiff == 1 && yDiff == 0)
            adjDir(i) = 3;
        elseif(xDiff == 0 && yDiff == -1)
            adjDir(i) = 2;
        elseif(xDiff == 0 && yDiff == 1)
            adjDir(i) = 4;
        else
            error('Error: invalid x diff %d and y diff %d',xDiff, yDiff);
        end
 
    end
    
    % right == 1, up == 2, left == 3, down == 4
    lastMoveList = [3 4 1 2];
    nextNode = 0;
    dir = 0;
    for i = 1:numAdjEdges
        
        % simply pick a direction for first move
        if(lastMove == 0)
            nextNode = adjEdgeVal(i).val;
            dir = adjDir(i);
        else
            % check that the adj is not the previous edge node 
            if(adjDir(i) ~= lastMoveList(lastMove))
                nextNode = adjEdgeVal(i).val;
                dir = adjDir(i);
            else
                %fprintf('Not taking direction %d\n', adjDir(i));
                continue
            end
        end
    end
    
    if(nextNode == 0)
        error('Error: nextNode not set');
    end
    
    if(dir == 0)
        error('Error: dir not set');
    end

   
    
end