% G = MakeGraph(env)
%
% creates a connect 2d graph from all the nodes in the env


function G = MakeGraph(env)

    % get size of env map
    [envHeight, envLength] = size(env.map);
    
    % initialize graph
    G = digraph;
    G = addnode(G,envHeight*envLength);
    
    % initialize names
    name = cell(1,envHeight*envLength);
    nodeType = zeros(1,envHeight*envLength);
    
    
    for i = 1:envLength*envHeight
        
        % get coordinate of node
        coordinate = ValToPosition(i,env);
        col = coordinate(1);
        row = coordinate(2);
        
        % get array index of node
        arrIndex = CoordToArray(coordinate, env);
        iA = arrIndex(1);
        jA = arrIndex(2);
        
        % name the node with (col, row)
        name(i) = cellstr(sprintf('(%d,%d)',col,row)); 
        nodeType(i) = env.map(iA,jA);

       
        % bottom left node
        % create edges: up, up-right, right
        if(i == 1)
            
            G = CreateEdge(G,env.map(iA,jA),[col,row],env.map(iA-1,jA),[col,row+1],env);
            G = CreateEdge(G,env.map(iA,jA),[col,row],env.map(iA-1,jA+1),[col+1,row+1],env);
            G = CreateEdge(G,env.map(iA,jA),[col,row],env.map(iA,jA+1),[col+1,row],env);
            
            
        
        % bottom right node
        % create edges: up-left, up
        elseif(i == envLength)
            
            G = CreateEdge(G,env.map(iA,jA),[col,row],env.map(iA-1,jA-1),[col-1,row+1],env);
            G = CreateEdge(G,env.map(iA,jA),[col,row],env.map(iA-1,jA),[col,row+1],env);

            
        % top right node
        % create edges: none
        elseif(i == envLength*envHeight)
            continue 
            
       % top left node
       % create edges: right
        elseif(i == (envLength*envHeight)-envLength+1)
            
            G = CreateEdge(G,env.map(iA,jA),[col,row],env.map(iA,jA+1),[col+1,row],env);
        
        % right middle node
        % create edges: up-left, up
        elseif(mod(i,envLength) == 0)
            
            G = CreateEdge(G,env.map(iA,jA),[col,row],env.map(iA-1,jA-1),[col-1,row+1],env);
            G = CreateEdge(G,env.map(iA,jA),[col,row],env.map(iA-1,jA),[col,row+1],env);
            
        % left middle node
        % create edges: up, up-right, right
        elseif(mod(i-1,envLength) == 0)
            
            G = CreateEdge(G,env.map(iA,jA),[col,row],env.map(iA-1,jA),[col,row+1],env);
            G = CreateEdge(G,env.map(iA,jA),[col,row],env.map(iA-1,jA+1),[col+1,row+1],env);
            G = CreateEdge(G,env.map(iA,jA),[col,row],env.map(iA,jA+1),[col+1,row],env);
            
            
        % top middle node
        % create edges: right
        elseif(i > ((envLength*envHeight)-envLength))
            
            G = CreateEdge(G,env.map(iA,jA),[col,row],env.map(iA,jA+1),[col+1,row],env);
        
        % bottom middle and middle nodes
        % create edges: up-left, up, up-right, right
        else
            
            G = CreateEdge(G,env.map(iA,jA),[col,row],env.map(iA-1,jA-1),[col-1,row+1],env);
            G = CreateEdge(G,env.map(iA,jA),[col,row],env.map(iA-1,jA),[col,row+1],env);
            G = CreateEdge(G,env.map(iA,jA),[col,row],env.map(iA-1,jA+1),[col+1,row+1],env);
            G = CreateEdge(G,env.map(iA,jA),[col,row],env.map(iA,jA+1),[col+1,row],env);

        end
        
    end
    
    % store names and sizes
    G.Nodes.Name = transpose(name);
    G.Nodes.Size = transpose(nodeType);
   
end