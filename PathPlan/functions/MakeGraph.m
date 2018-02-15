
function G = MakeGraph(envMap)

    % get size of env map
    [height, length] = size(envMap);
    
    % initialize graph
    G = graph;
    G = addnode(G,height*length);
    
    for i = 1:length*height
       
        % top left node
        % create edges: right, down-right, down
        if(i == 1)
            G = addedge(G,i,i+1,1);
            G = addedge(G,i,i+length,1);
            G = addedge(G,i,i+length+1,1);
        
        % top right node
        % create edges: down-left, down
        elseif(i == length)
            G = addedge(G,i,i+length,1);
            G = addedge(G,i,i+length-1,1);
            
        % bottom right node
        % create edges: none
        elseif(i == length*height)
            continue 
            
       % bottom left node
       % create edges: right
        elseif(i == (length*height)-length+1)
            G = addedge(G,i,i+1,1);
        
        % right middle node
        % create edges: down-left, down
        elseif(mod(i,length) == 0)
            G = addedge(G,i,i+length-1,1);
            G = addedge(G,i,i+length,1);
            
        % left middle node
        % create edges: right, down-right, down
        elseif(mod(i-1,length) == 0)
            G = addedge(G,i,i+1,1);
            G = addedge(G,i,i+length+1,1);
            G = addedge(G,i,i+length,1);
            
        % bottom middle node
        % create edges: right
        elseif(i > (length*height)-length+1)
            G = addedge(G,i,i+1,1);
        
        % top middle and middle nodes
        % create edges: right, down-right, down, down-left
        else
            G = addedge(G,i,i+1,1);
            G = addedge(G,i,i+length+1,1);
            G = addedge(G,i,i+length,1);
            G = addedge(G,i,i+length-1,1);

        end
        
    end

end