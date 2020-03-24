function cloud = updateCloud(cloud)
%eventually include more 
%vector order is: [x1 y2 z2 vx2 vy2 vz x2 y2 z2 vx2 vy2 vz2...];
    
    cloud.varOrder = varOrder(cloud.numAtoms);
    cloud.vector = [];
    for i = 1:cloud.numAtoms
        cloud.vector = [cloud.vector cloud.atoms{i}.xyz cloud.atoms{i}.vxvyvz];
    end
    cloud.vector = cloud.vector';
    
    potentialSet = {}; %potentialSet = {x1 y1 z1 x2 y2 z2...}
    for i = 1:cloud.numAtoms
        potentialSet{end+1} = cloud.atoms{i}.potentialx; 
        potentialSet{end+1} = cloud.atoms{i}.potentialy;
        potentialSet{end+1} = cloud.atoms{i}.potentialz;
    end
    cloud.potentialSet = potentialSet; 
