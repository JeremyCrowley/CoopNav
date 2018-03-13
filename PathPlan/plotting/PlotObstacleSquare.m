% p = PlotObstacleSquare(center, p)

function p = PlotObstacleSquare(center,color,transparency)

    x = [center(1)-0.5 center(1)-0.5 center(1)+0.5 center(1)+0.5]; 
    y = [center(2)-0.5 center(2)+0.5 center(2)+0.5 center(2)-0.5]; 
    patch(x,y,color,'FaceAlpha',transparency,'LineWidth',1);

end