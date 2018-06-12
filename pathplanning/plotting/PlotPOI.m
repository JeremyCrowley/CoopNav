
function p = PlotPOI(POI, env)

    % show points of interest
    numPOI = length(POI);
    
    for i = 1:numPOI
        
        poiCoord = ValToPosition(POI(i),env);
        
        p(i) = scatter(poiCoord(1),poiCoord(2),50,[1 0 0],'filled');
        
       
    end
end