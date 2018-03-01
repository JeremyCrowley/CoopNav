
function G = MakeGraph(envMap)

    % get size of env map
    [rowNum, colNum] = size(envMap);
    
    % initialize graph
    G = graph;
    G = addnode(G,rowNum*colNum);
    
    % initialize names
    name = cell(1,rowNum*colNum);
    nodeType = zeros(1,rowNum*colNum);
    
    
    for i = 1:colNum*rowNum
        
        row = floor((i-1)/(colNum))+1;
        col = i - (row-1)*colNum;
        
        % name the node with (row, col)
        name(i) = cellstr(sprintf('(%d,%d)',row,col));
        
        nodeType(i) = envMap(row,col);
       
        % top left node
        % create edges: right, down-right, down
        if(i == 1)
            
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row,col+1),[row,col+1],colNum);
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col+1),[row+1,col+1],colNum);
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col),[row+1,col],colNum);
        
        % top right node
        % create edges: down-left, down
        elseif(i == colNum)
            
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col-1),[row+1,col-1],colNum);
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col),[row+1,col],colNum);

            
        % bottom right node
        % create edges: none
        elseif(i == colNum*rowNum)
            continue 
            
       % bottom left node
       % create edges: right
        elseif(i == (colNum*rowNum)-colNum+1)
            
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row,col+1),[row,col+1],colNum);
        
        % right middle node
        % create edges: down-left, down
        elseif(mod(i,colNum) == 0)
            
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col-1),[row+1,col-1],colNum);
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col),[row+1,col],colNum);
            
        % left middle node
        % create edges: right, down-right, down
        elseif(mod(i-1,colNum) == 0)
            
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row,col+1),[row,col+1],colNum);
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col+1),[row+1,col+1],colNum);
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col),[row+1,col],colNum);
            
            
        % bottom middle node
        % create edges: right
        elseif(i > (colNum*rowNum)-colNum+1)
            
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row,col+1),[row,col+1],colNum);
        
        % top middle and middle nodes
        % create edges: right, down-right, down, down-left
        else
            
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row,col+1),[row,col+1],colNum);
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col+1),[row+1,col+1],colNum);
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col),[row+1,col],colNum);
            G = CreateEdge(G,envMap(row,col),[row,col],envMap(row+1,col-1),[row+1,col-1],colNum); 

        end
        
    end
    
    G.Nodes.Name = transpose(name);
    G.Nodes.Size = transpose(nodeType);
    
    %G.Nodes;

end