function plot2dTrajectory(cloud,dim1,dim2,timeWindow)
if nargin < 4
    timeWindow = [0 Inf];
    titlestring = 'all times';
else
    titlestring = sprintf('%3.0f usec < t < %3.0f usec',timeWindow(1)*1e6,timeWindow(2)*1e6);
end
for i = 1:cloud.numIons
    x1 = pullTrajectory(cloud,sprintf('%c%d',dim1,i),timeWindow);
    y1 = pullTrajectory(cloud,sprintf('%c%d',dim2,i),timeWindow);
    plot(x1,y1);
    hold all;
end
forceSquare();
xlabel(dim1);
ylabel(dim2);
title(titlestring);

%Produces a plot of the trajectories of the ions in 2 dimensions, during
%some specified window of time. Parameters:
%cloud is the cloud of ions whose trajectories you want to see, produced by
% initializeCloud() and evolved by evolveCloud().
%dim1 is the dimension you want to plot along the horizontal axis, and dim2
% is the dimension you want to plot along the vertical axis. Both are
% either 'x','y', or 'z'
% timeWindow is an array, the window of time you want to plot the
% trajectories through: [startTime endTime] (ex. [0 1e-3])
