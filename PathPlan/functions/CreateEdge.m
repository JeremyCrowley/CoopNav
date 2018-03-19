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

    
    % determine if the nodes are diagnal or straight
    diag = 0;
    if(node1Pos(1) ~= node2Pos(1) && node1Pos(2) ~= node2Pos(2))
        diag = 1;
    end
    
    % to free space
    if(node2Val == 0)
        if(diag)
            weight_12 = sqrt(2);
        else
            weight_12 = 1;
        end
    % to obstacle boundary
    elseif(node2Val == 1)
        if(diag)
            weight_12 = sqrt(8);
        else
            weight_12 = 2;
        end
	% to obstacle
    elseif(node2Val == 2)        
        weight_12 = 1000;
	% incorrect relation between two nodes
    else
        error('Error: Invalid node2 value %d\n',node2Val);
    end
    
    % to free space
    if(node1Val == 0)
        if(diag)
            weight_21 = sqrt(2);
        else
            weight_21 = 1;
        end
    % to obstacle boundary
    elseif(node1Val == 1)
        if(diag)
            weight_21 = sqrt(8);
        else
            weight_21 = 2;
        end
	% to obstacle
    elseif(node1Val == 2)        
        weight_21 = 1000;
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
