
% returns convex hull from point cloud
function obj = MakeObj2D(points)
    %figure()
    % create face representation and create convex hull
    F = convhull(points(:,1), points(:,2));
    S.Vertices = points;
    S.Faces = F;
    S.FaceVertexCData = jet(size(points,1));
    S.FaceColor = 'interp';
    %transpose(S.Vertices(:,1))
    %transpose(S.Vertices(:,2))
    obj = patch(transpose(S.Vertices(:,1)),transpose(S.Vertices(:,2)),'red');
    %obj = patch(S);
    
end