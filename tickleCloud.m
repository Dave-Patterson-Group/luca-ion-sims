function cloud = tickleCloud(cloud)
r = 1e-4;
for i = 0:(cloud.numIons-1)
    cloud.vector(6*i + 1) = normrnd(0,r);
    cloud.vector(6*i + 2) = normrnd(0,r);    % Random initial positions
    cloud.vector(6*i + 3) = normrnd(0,r);
%     cloud.vector(6*i + 4) = normrnd(0,10);
%     cloud.vector(6*i + 5) = normrnd(0,10);  % Random initial velocities
%     cloud.vector(6*i + 6) = normrnd(0,10);
end
cloud = updateIons(cloud);