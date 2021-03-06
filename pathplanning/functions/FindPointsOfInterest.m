% POI = FindPointsOfInterest(circularEdgeLinkedList, freeSpaceThreshold, env, targetNode)
%
% locates the points of interest in the environment


function POI = FindPointsOfInterest(circularEdgeLinkedList, freeSpaceThreshold, env, targetNode)
    
    [circHeight, circLength] = size(circularEdgeLinkedList.node);
    
    % set first pass struct
    firstPass.true = 1;
    firstPass.freeSpaceCounter = 0;
    firstPass.obstacleBoundaryCounter = 0;
    firstPass.obstacleCounter = 0;
       
    % initialize counters
    freeSpaceCounter = 0;
    obstacleBoundaryCounter = 0;
    obstacleCounter = 0;
    POIcount = 0;
    
    % initiailize flags
    freeSpaceFlag = 0;
    
    for i = 1:circLength
        
        

        % get coordinates and array index for current edge node
        coordinate = ValToPosition(circularEdgeLinkedList.node(i).nodeNum, env);
        arrIndex = CoordToArray(coordinate, env);
       
        % obstacle
        if(env.map(arrIndex(1),arrIndex(2)) == 2)
            
            obstacleCounter = obstacleCounter + 1;
            
            % changed from obstacle boundary to obstacle
            if(obstacleBoundaryCounter ~= 0)
                firstPass.true = 0;
            end
            
            % changed from free space to obstacle
            if(freeSpaceCounter ~= 0)
                error('Error: Transition from free space to obstacle without boundary in between')
            end

        % obstacle boundary
        elseif(env.map(arrIndex(1),arrIndex(2)) == 1)
            
            obstacleBoundaryCounter = obstacleBoundaryCounter + 1;
            
            % POI - transition from free space to obstacle boundary
            if(freeSpaceCounter  ~= 0)

                % add POI to list
                
                if(~IsNodeEdgeEnv(circularEdgeLinkedList.node(i).nodeNum,env))
                    POIcount = POIcount + 1;
                    POI(POIcount) = circularEdgeLinkedList.node(i).nodeNum;
                end
                
                % POI - long enough free space without being first pass
                if(~firstPass.true && freeSpaceFlag)
                   
                    % go back and make POIs
                    for j = 1:freeSpaceCounter
                        if(mod(j,ceil(freeSpaceThreshold/2)) == 0)
                            
                            if(~IsNodeEdgeEnv(circularEdgeLinkedList.node(i-j).nodeNum,env))
                                POIcount = POIcount + 1;
                                POI(POIcount) = circularEdgeLinkedList.node(i-j).nodeNum;
                            end
                        end
                    end
                    
                    
                end
                
                % reset flag
                freeSpaceFlag = 0;
                
                % reset first pass flags
                firstPass.true = 0;
                % reset counter
                freeSpaceCounter = 0;

            end
            
            % changed from obstacle to obstacle boundary
            if(obstacleCounter  ~= 0)
                firstPass.true = 0;
            end
            
        % free space
        elseif(env.map(arrIndex(1),arrIndex(2)) == 0)
            
            
            freeSpaceCounter = freeSpaceCounter + 1;
           
            
            % set free space counter if above threshold of free space nodes
            if(freeSpaceCounter > freeSpaceThreshold)
                freeSpaceFlag = 1;
            end
            
            % POI - transition from obstacle boundary to free space
            if(obstacleBoundaryCounter  ~= 0)
                firstPass.true = 0;
                obstacleBoundaryCounter = 0;
                
                if(~IsNodeEdgeEnv(circularEdgeLinkedList.node(i).prevNode,env))
                    POIcount = POIcount + 1;
                    POI(POIcount) = circularEdgeLinkedList.node(i).prevNode;
                end
                
            end

        % invalid node value
        else
            error('Error: Invalid node value %d at (%d,%d)', circularEdgeLinkedList.node(i).nodeNum, coordinate(1), coordinate(2));
        end
        
        
        % update first pass values
        if(firstPass.true)
            firstPass.freeSpaceCounter = freeSpaceCounter;
            firstPass.obstacleBoundaryCounter = obstacleBoundaryCounter;
            firstPass.obstacleCounter = obstacleCounter;
        end 
        
    end
    
    
    % started and ended with free space
    if(freeSpaceCounter > 0 && firstPass.freeSpaceCounter > 0)

        % if still on first pass do not double count the free space length
        if(firstPass.true)
            freeSpaceLength = freeSpaceCounter;
        else
            freeSpaceLength = freeSpaceCounter + firstPass.freeSpaceCounter;
        end
        
        % go back and make POIs
        for j = 1:freeSpaceLength-1
            if(mod(j,ceil(freeSpaceThreshold/2)) == 0)
                
                
                circIndex = mod(circLength-freeSpaceCounter+j,circLength)+1;
                if(~IsNodeEdgeEnv(circularEdgeLinkedList.node(circIndex).nodeNum,env))
                    POIcount = POIcount + 1;
                    POI(POIcount) = circularEdgeLinkedList.node(circIndex).nodeNum;
                end
            end
        end
       
    % started with free space and ended with obstacle boundary
    elseif(obstacleBoundaryCounter > 0 && firstPass.freeSpaceCounter > 0)
        
        POIcount = POIcount + 1;
        POI(POIcount) = circularEdgeLinkedList.node(circLength).nodeNum;
        
        
        % go back and make POIs
        for j = 1:firstPass.freeSpaceCounter-1
            if(mod(j,ceil(freeSpaceThreshold/2)) == 0)
                
                if(~IsNodeEdgeEnv(circularEdgeLinkedList.node(j).nodeNum,env))
                    POIcount = POIcount + 1;
                    POI(POIcount) = circularEdgeLinkedList.node(j).nodeNum;
                end
            end
        end
        
        
    % started with obstacle boundary and ended with free space
    elseif(freeSpaceCounter > 0 && firstPass.obstacleBoundaryCounter > 0)
        
        % make sure this obstacle boundary is not already a POI
        if(~(circularEdgeLinkedList.node(1).nodeNum == POI(1)))            
            POIcount = POIcount + 1;
            POI(POIcount) = circularEdgeLinkedList.node(1).nodeNum;  
        end
        
        % POI - go back and make POIs in free space 
        if(freeSpaceFlag)

            % go back and make POIs
            for j = 1:freeSpaceCounter
                if(mod(j,ceil(freeSpaceThreshold/2)) == 0)
                    POIcount = POIcount + 1;
                    POI(POIcount) = circularEdgeLinkedList.node(i-j).nodeNum;
                end
            end


        end
        
        
    % do not need to loop back to set another POI
    else
        %fprintf('Note: ending sequence does not warrant more POIs');
        0;
    end
    
    
    %  add target to POI if it has been discovered
    targetCoord = ValToPosition(targetNode,env);
    targetArrIndex = CoordToArray(targetCoord,env);
    
    if(env.node(targetArrIndex(1),targetArrIndex(2)).discovered == 1)
        POIcount = POIcount + 1;
        POI(POIcount) = targetNode;  
    end
    

end