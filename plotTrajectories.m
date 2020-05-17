function plotTrajectories(cloud,lateTimes,lateTimes2,lateTimes3,lateTimes4,lateTimes5)
%This is a bit of an older function which does a few things. It plots the
%x, y, and z motion of the first ion in the cloud as a function of time,
%the energy of the cloud, as a function of time, and 2D trajectory plots
%for the time spans lateTimes, lateTimes2, lateTimes3, lateTimes4, and
%lateTimes5, all of which are optional arguments (see the
%plotJustTrajectories() function, it works the same way). This function is most
%useful if you're dealing with a cloud of a single ion and want to see a
%whole bunch of information at once.

doeslateTimes2 = 1;
doeslateTimes3 = 1;
doeslateTimes4 = 1;
doeslateTimes5 = 1;

if nargin < 2
    lateTimes = [0.5e-3 Inf];
end
if nargin < 3
    doeslateTimes2 = 0;
end
if nargin < 4
    doeslateTimes3 = 0;
end
if nargin < 5
    doeslateTimes4 = 0;
end
if nargin < 6
    doeslateTimes5 = 0;
end
figure('Position',[80   80   1000   700],'Name',sprintf('%d atom cloud',cloud.numIons));
subplot(3,1,1);
plotXYZ(cloud,1)
%plotXYZ(cloud,2)
%plotXYZ(cloud,0)


subplot(4,1,2);
plotEnergy(cloud);
%subplot(3,1,2);
%plotXYZ(cloud,2)

if doeslateTimes2
    subplot(4,6,13);
    plot2dTrajectory(cloud,'x','y');
    subplot(4,6,14);
    plot2dTrajectory(cloud,'x','y',lateTimes);
    subplot(4,6,15);
    plot2dTrajectory(cloud,'x','y',lateTimes2);
else
    subplot(4,4,9);
    plot2dTrajectory(cloud,'x','y');
    subplot(4,4,10);
    plot2dTrajectory(cloud,'x','y',lateTimes);
end
if doeslateTimes3
    subplot(4,6,16);
    plot2dTrajectory(cloud,'x','y',lateTimes3);
end
if doeslateTimes4
    subplot(4,6,17);
    plot2dTrajectory(cloud,'x','y',lateTimes4);
end
if doeslateTimes5
    subplot(4,6,18);
    plot2dTrajectory(cloud,'x','y',lateTimes5);
end

if doeslateTimes2
    subplot(4,6,19);
    plot2dTrajectory(cloud,'z','x');
    subplot(4,6,20);
    plot2dTrajectory(cloud,'z','x',lateTimes);
    subplot(4,6,21);
    plot2dTrajectory(cloud,'z','x',lateTimes2);
else
    subplot(4,4,13);
    plot2dTrajectory(cloud,'z','x');
    subplot(4,4,14);
    plot2dTrajectory(cloud,'z','x',lateTimes);
end
if doeslateTimes3
    subplot(4,6,22);
    plot2dTrajectory(cloud,'z','x',lateTimes3);
end
if doeslateTimes4
    subplot(4,6,23);
    plot2dTrajectory(cloud,'z','x',lateTimes4);
end
if doeslateTimes5
    subplot(4,6,24);
    plot2dTrajectory(cloud,'z','x',lateTimes5);
end
