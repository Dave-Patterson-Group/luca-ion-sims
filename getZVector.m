function zVector = getZVector(cloud,vector)
if nargin < 2
    vector = cloud.vector;
end
zPositions = zeros(1,cloud.numAtoms);
for i = 1:cloud.numAtoms
    zPositions(i) = vector(3 + (6 * (i-1)));
end
zVector = sort(zPositions);
