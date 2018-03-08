% G = CreateEdge(G, node1Val, node1Pos, node2Val, node2Pos)
%
% creates an edge between coordinates node1Pos and node2Pos
%
% G         - graph
% node1Val  - 0 for free space, 1 for obstacle boundary, 2 for obstacle
% node1Pos  - coordinate pair for a node
%
%


function G = CreateEdge(G, node1Val, node1Pos, node2Val, node2Pos, length)

    
    % determine if the nodes are diagnal or straight
    diag = 0;
    if(node1Pos(1) ~= node2Pos(1) && node1Pos(2) ~= node2Pos(2))
        diag = 1;
    end
    
    % both nodes are free space
    if(node1Val == 0 && node2Val == 0)
        
        if(diag)
            weight = sqrt(2);
        else
            weight = 1;
        end
       
    % one node is free space and the other is obstacle boundary
    elseif(node1Val == 1 && node2Val == 0 || node1Val == 0 && node2Val == 1)
        
        if(diag)
            weight = sqrt(8);
        else
            weight = 2;
        end
        
	% both nodes are obstacle boundaries
	elseif(node1Val == 1 && node2Val == 1)
        
        if(diag)
            weight = sqrt(32);
        else
            weight = 4;
        end
        
	% one node is obstacle boundary and the other is obstacle
    elseif(node1Val == 2 && node2Val == 1 || node1Val == 1 && node2Val == 2)        
        
        weight = 1000;
    
    
    elseif(node1Val == 2 && node2Val == 2)
        
        weight = 2000;
        
	% incorrect relation between two nodes
    else
        
        error('Invalid node type pair %d and %d between nodes (%d,%d) and (%d,%d)', node1Val, node2Val,node1Pos(1),node1Pos(2),node2Pos(1),node2Pos(2));
        
    end   

    node1 = PositionToVal(node1Pos,length);
    node2 = PositionToVal(node2Pos,length);
    
    G = addedge(G,node1,node2,weight);

end
