function cloud = updateCloud(cloud)
%vector order is: [x1 y2 z2 vx2 vy2 vz x2 y2 z2 vx2 vy2 vz2...];

cloud.varOrder = varOrder(cloud.numIons);
cloud.vector = [];
for i = 1:cloud.numIons
    cloud.vector = [cloud.vector cloud.ions{i}.xyz cloud.ions{i}.vxvyvz];
end

potentialSet = cell(1,3*cloud.numIons); % potentialSet = {x1 y1 z1 x2 y2 z2...}
for i = 1:cloud.numIons
    potentialSet{3*(i-1) + 1} = cloud.ions{i}.potentialx;
    potentialSet{3*(i-1) + 2} = cloud.ions{i}.potentialy;
    potentialSet{3*(i-1) + 3} = cloud.ions{i}.potentialz;
end
cloud.potentialSet = potentialSet;
