% p = PlotObstacleSquare(center, p)

function p = PlotObstacleSquare(center,color)

    x = [center(1)-0.5 center(1)-0.5 center(1)+0.5 center(1)+0.5]; 
    y = [center(2)-0.5 center(2)+0.5 center(2)+0.5 center(2)-0.5]; 
    patch(x,y,color,'FaceAlpha',.25,'LineWidth',1);

end