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

%Whichvar is either 'x1','y1','z1','x2,'y2', ... 'xN','yN', or 'zN'
%where N is the total number of ions. picking 'x1' causes the function to
%return the x-trajectory of the first ion in the specified timeWindow
%[startTime endTime]. Picking 'y2' returns the y trajectory of the 2nd ion,
%and so on.