
function G = MakeGraph(envMap)

    % get size of env map
    [envHeight, envLength] = size(envMap);
    
    % initialize graph
    G = graph;
    G = addnode(G,envHeight*envLength);
    
    % initialize names
    name = cell(1,envHeight*envLength);
    nodeType = zeros(1,envHeight*envLength);
    
    
    for i = 1:envLength*envHeight
        
        
        coordinate = ValToPosition(i,envLength);
        
        
        
        col = coordinate(1);
        row = coordinate(2);
        %row = floor((i-1)/(colNum))+1;
        %col = i - (row-1)*colNum;
        
        % name the node with (row, col)
        name(i) = cellstr(sprintf('(%d,%d)',row,col));
        
        nodeType(i) = envMap(row,col);
       
        % top left node
        % create edges: right, down-right, down
        if(i == 1)
            
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row,col+1),[row,col+1],envLength);
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col+1),[row+1,col+1],envLength);
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col),[row+1,col],envLength);
        
        % top right node
        % create edges: down-left, down
        elseif(i == envLength)
            
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col-1),[row+1,col-1],envLength);
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col),[row+1,col],envLength);

            
        % bottom right node
        % create edges: none
        elseif(i == envLength*envHeight)
            continue 
            
       % bottom left node
       % create edges: right
        elseif(i == (envLength*envHeight)-envLength+1)
            
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row,col+1),[row,col+1],envLength);
        
        % right middle node
        % create edges: down-left, down
        elseif(mod(i,envLength) == 0)
            
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col-1),[row+1,col-1],envLength);
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col),[row+1,col],envLength);
            
        % left middle node
        % create edges: right, down-right, down
        elseif(mod(i-1,envLength) == 0)
            
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row,col+1),[row,col+1],envLength);
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col+1),[row+1,col+1],envLength);
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col),[row+1,col],envLength);
            
            
        % bottom middle node
        % create edges: right
        elseif(i > (envLength*envHeight)-envLength+1)
            
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row,col+1),[row,col+1],envLength);
        
        % top middle and middle nodes
        % create edges: right, down-right, down, down-left
        else
            
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row,col+1),[row,col+1],envLength);
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col+1),[row+1,col+1],envLength);
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col),[row+1,col],envLength);
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col-1),[row+1,col-1],envLength); 

        end
        
    end
    name
    G.Nodes.Name = transpose(name);
    G.Nodes.Size = transpose(nodeType);
    
    %G.Nodes;

end