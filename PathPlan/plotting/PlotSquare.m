% p = PlotSquare(center, p)

function p = PlotSquare(center,color,transparency)

    x = [center(1)-0.5 center(1)-0.5 center(1)+0.5 center(1)+0.5]; 
    y = [center(2)-0.5 center(2)+0.5 center(2)+0.5 center(2)-0.5]; 
    p = patch(x,y,color,'FaceAlpha',transparency,'LineWidth',1);

end