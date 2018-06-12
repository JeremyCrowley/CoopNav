% G = CreateEdge(G, node1Val, node1Pos, node2Val, node2Pos)
%
% creates an edge between coordinates node1Pos and node2Pos
%
% G         - graph
% node1Val  - 0 for free space, 1 for obstacle boundary, 2 for obstacle
% node1Pos  - coordinate pair for a node
%
%


function G = CreateEdge(G, node1Val, node1Pos, node2Val, node2Pos, env)

    %[envHeight, envLength] = size(env.map);

	freespaceMult = 1;
    obstboundMult = 10;
    obstMult = 10000;
    
    % determine if the nodes are diagnal or straight
    diag = 0;
    if(node1Pos(1) ~= node2Pos(1) && node1Pos(2) ~= node2Pos(2))
        diag = 1;
    end
    
    % to free space
    if(node2Val == 0)
        if(diag)
            weight_12 = sqrt(freespaceMult^2 + freespaceMult^2);
        else
            weight_12 = freespaceMult;
        end
    % to obstacle boundary
    elseif(node2Val == 1)
        if(diag)
            weight_12 = sqrt(obstboundMult^2 + obstboundMult^2);
        else
            weight_12 = obstboundMult;
        end
	% to obstacle
    elseif(node2Val == 2)        
        weight_12 = obstMult;
	% incorrect relation between two nodes
    else
        error('Error: Invalid node2 value %d\n',node2Val);
    end
    
    % to free space
    if(node1Val == 0)
        if(diag)
            weight_21 = sqrt(freespaceMult^2 + freespaceMult^2);
        else
            weight_21 = freespaceMult;
        end
    % to obstacle boundary
    elseif(node1Val == 1)
        if(diag)
            weight_21 = sqrt(obstboundMult^2 + obstboundMult^2);
        else
            weight_21 = obstboundMult;
        end
	% to obstacle
    elseif(node1Val == 2)        
        weight_21 = obstMult;
	% incorrect relation between two nodes
    else
        error('Error: Invalid node1 value %d\n',node1Val);
    end

    node1 = PositionToVal(node1Pos,env);
    node2 = PositionToVal(node2Pos,env);
    
    %fprintf('edges between %d and %d\n',node1,node2);
    G = addedge(G,node1,node2,weight_12);
    G = addedge(G,node2,node1,weight_21);

end
