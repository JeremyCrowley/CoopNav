
function G = MakeGraph(envMap)

    [height, length] = size(envMap)
    
    G = graph
     
    G = addnode(G,height*length);
    
    for i = 1:length*height
       
        % top left 
        if(i == 1)
            % right, down-right, down
            G = addedge(G,i,i+1,1);
            G = addedge(G,i,i+length,1);
            G = addedge(G,i,i+length+1,1);
        
        % top right 
        elseif(i == length)
            G = addedge(G,i,i+length,1);
            G = addedge(G,i,i+length-1,1);
            
        % bottom right 
        elseif(i == length*height)
            continue 
            
       % bottom left
        elseif(i == (length*height)-length+1)
            G = addedge(G,i,i+1,1);
        
        % right middle
        elseif(mod(i,height) == 0)
            G = addedge(G,i,i+length-1,1)
            G = addedge(G,i,i+length,1)
            
        % left middle
        elseif(mod(i-1,length) == 0)
            G = addedge(G,i,i+1,1);
            G = addedge(G,i,i+length+1,1);
            G = addedge(G,i,i+length,1);
            
        % bottom middle
        elseif(i > (length*height)-length+1)
            G = addedge(G,i,i+1,1);
        
        % top middle and middle    
        else
            G = addedge(G,i,i+1,1);
            G = addedge(G,i,i+length+1,1);
            G = addedge(G,i,i+length,1);
            G = addedge(G,i,i+length-1,1);

        end
        
    end
    
    
    
    


end