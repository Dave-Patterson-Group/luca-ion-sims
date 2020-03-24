function plotTrajectories(cloud,lateTimes,lateTimes2,lateTimes3,lateTimes4,lateTimes5)
doeslateTimes2 = 1;
doeslateTimes3 = 1;
doeslateTimes4 = 1;
doeslateTimes5 = 1;
isMixed = 0;
if strcmp(cloud.isMixed,'mixed')
    isMixed = 1;
end
if strcmp(cloud.isMixed,'mlcls')
    isMixed = 2;
end
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
figure('Position',[82   107   1414   839],'Name',sprintf('%d atom cloud',cloud.numAtoms));
subplot(3,1,1);
plotXYZ(cloud,1)
plotXYZ(cloud,2)
% plotXYZ(cloud,0)
a= dbstack;
title([a(2).name '()']);

subplot(4,1,2);
plotEnergy(cloud);
%subplot(3,1,2);
%plotXYZ(cloud,2)

str1 = " Sr - (" + (cloud.atoms{1}.potentialx.freq / 1000) + " kHz," + (cloud.atoms{1}.potentialy.freq / 1000) + " kHz," + (cloud.atoms{1}.potentialz.freq / 1000)+ " kHz) ";
str2 = " ";
if (isMixed == 2)
    str1 = " ";
    str2 = " SrO - (" + (cloud.atoms{1}.potentialx.freq / 1000) + " kHz," + (cloud.atoms{1}.potentialy.freq / 1000) + " kHz," + (cloud.atoms{1}.potentialz.freq / 1000)+ " kHz) ";
end

if (isMixed == 1)
    str2 = " SrO - (" + (cloud.atoms{2}.potentialx.freq / 1000) + " kHz," + (cloud.atoms{2}.potentialy.freq / 1000) + " kHz," + (cloud.atoms{2}.potentialz.freq / 1000)+ " kHz) ";
end
annotation('textbox', [0.1, 0.99, 0.75, 0.01], 'String', "Atoms: " + cloud.numIons + " Molecules: " + cloud.numMolecules + "  Frequencies: " + str1 + str2,'FitBoxToText','on');

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
