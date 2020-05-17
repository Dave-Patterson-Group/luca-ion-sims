function zVector = getZVector(cloud,vector)
if nargin < 2
    vector = cloud.vector;
end
zPositions = zeros(1,cloud.numIons);
for i = 1:cloud.numIons
    zPositions(i) = vector(3 + (6 * (i-1)));
end
zVector = sort(zPositions);

%returns a sorted vector of all of the z-positions of each ion in the
%cloud.