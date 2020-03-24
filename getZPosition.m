function moleculeZ = getZPosition(cloud,vector)
if nargin < 2
    vector = cloud.vector;
end
zPositions = zeros(1,cloud.numAtoms);
for i = 1:cloud.numAtoms
    zPositions(i) = vector(3 + (6 * (i-1)));
end
molZPos = zPositions(end);
sortedPositions = sort(zPositions);
for j = 1:cloud.numAtoms
    if sortedPositions(j) == molZPos
        moleculeZ = j;
    end
end
