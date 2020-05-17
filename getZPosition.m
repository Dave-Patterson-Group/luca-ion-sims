function moleculeZ = getZPosition(cloud,vector)
if nargin < 2
    vector = cloud.vector;
end
zPositions = zeros(1,cloud.numAtoms);
for i = 1:cloud.numIons
    zPositions(i) = vector(3 + (6 * (i-1)));
end
molZPos = zPositions(end);
sortedPositions = sort(zPositions);
for j = 1:cloud.numIons
    if sortedPositions(j) == molZPos
        moleculeZ = j;
    end
end


%This function has a fairly limited use case, if you have a chain of ions,
%with all of them strontium except for 1 dark ion, this will return which
%position in the chain the dark ion is in. If it returns 1, that means the
%dark ion is all the way on the left. If it returns 2, it's the second
%from the left, and so on, where if it returns numIons, it's all the way on
%the right.