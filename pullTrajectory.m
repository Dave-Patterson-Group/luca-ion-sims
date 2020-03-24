function coord = pullTrajectory(cloud,whichVar,timeWindow)
if nargin < 3
    timeWindow = [0 Inf];
end
firsti = find(cloud.times >= timeWindow(1),1,'first');
lasti = find(cloud.times <= timeWindow(2),1,'last');
for i = 1:length(cloud.varOrder)
    if strcmp(whichVar,cloud.varOrder{i})
        coord = cloud.trajectories(:,i);
    end
end
coord = coord(firsti:lasti);
