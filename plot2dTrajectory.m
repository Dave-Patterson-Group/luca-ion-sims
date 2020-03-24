function plot2dTrajectory(cloud,dim1,dim2,timeWindow)
if nargin < 4
    timeWindow = [0 Inf];
    titlestring = 'all times';
else
    titlestring = sprintf('%3.0f usec < t < %3.0f usec',timeWindow(1)*1e6,timeWindow(2)*1e6);
end
for i = 1:cloud.numAtoms
    x1 = pullTrajectory(cloud,sprintf('%c%d',dim1,i),timeWindow);
    y1 = pullTrajectory(cloud,sprintf('%c%d',dim2,i),timeWindow);
    plot(x1,y1);
    hold all;
end
forceSquare();
xlabel(dim1);
ylabel(dim2);
title(titlestring);x = randn;
