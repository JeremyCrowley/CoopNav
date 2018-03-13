% adjacentBool = AreNodesAdjacent(node1Num, node2Num)

function adjacentBool = AreNodesAdjacent(node1Num, node2Num, env)

    if(node1Num == node2Num)
        error('Error: duplicate nodes entered');
    end
    
    coord1 = ValToPosition(node1Num,env);
    coord2 = ValToPosition(node2Num,env);
    
    adjacentBool = 0;
    if(abs(coord1(1)-coord2(1)) <= 1 && abs(coord1(2)-coord2(2)) <= 1)
        adjacentBool = 1;
    end
    

end
