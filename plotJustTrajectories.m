function plotJustTrajectories(cloud,lateTimes,lateTimes2,lateTimes3,lateTimes4,lateTimes5)
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
width = (2 + doeslateTimes2 + doeslateTimes3 + doeslateTimes4 + doeslateTimes5) * 300;
figure('Position',[82   107   width   630],'Name',sprintf('%d atom cloud',cloud.numAtoms));
% 
% str1 = " Sr - (" + (cloud.atoms{1}.potentialx.freq / 1000) + " kHz," + (cloud.atoms{1}.potentialy.freq / 1000) + " kHz," + (cloud.atoms{1}.potentialz.freq / 1000)+ " kHz) ";
% if (isMixed == 2)
%     str1 = " ";
% end
% 
% str2 = " ";
% if ((isMixed == 1) || (isMixed == 2))
%     str2 = " SrO - (" + (cloud.atoms{2}.potentialx.freq / 1000) + " kHz," + (cloud.atoms{2}.potentialy.freq / 1000) + " kHz," + (cloud.atoms{2}.potentialz.freq / 1000)+ " kHz) ";
% end
% annotation('textbox', [0.1, 0.99, 0.75, 0.01], 'String', "Atoms: " + cloud.numIons + " Molecules: " + cloud.numMolecules + "  Frequencies: " + str1 + str2,'FitBoxToText','on');

if doeslateTimes5
    subplot(2,6,1);
    plot2dTrajectory(cloud,'x','y');
    subplot(2,6,2);
    plot2dTrajectory(cloud,'x','y',lateTimes);
    subplot(2,6,3);
    plot2dTrajectory(cloud,'x','y',lateTimes2);
    subplot(2,6,4);
    plot2dTrajectory(cloud,'x','y',lateTimes3);
    subplot(2,6,5);
    plot2dTrajectory(cloud,'x','y',lateTimes4);
    subplot(2,6,6);
    plot2dTrajectory(cloud,'x','y',lateTimes5);
    
    subplot(2,6,7);
    plot2dTrajectory(cloud,'z','x');
    subplot(2,6,8);
    plot2dTrajectory(cloud,'z','x',lateTimes);
    subplot(2,6,9);
    plot2dTrajectory(cloud,'z','x',lateTimes2);
    subplot(2,6,10);
    plot2dTrajectory(cloud,'z','x',lateTimes3);
    subplot(2,6,11);
    plot2dTrajectory(cloud,'z','x',lateTimes4);
    subplot(2,6,12);
    plot2dTrajectory(cloud,'z','x',lateTimes5);
else
    if doeslateTimes4
        subplot(2,5,1);
        plot2dTrajectory(cloud,'x','y');
        subplot(2,5,2);
        plot2dTrajectory(cloud,'x','y',lateTimes);
        subplot(2,5,3);
        plot2dTrajectory(cloud,'x','y',lateTimes2);
        subplot(2,5,4);
        plot2dTrajectory(cloud,'x','y',lateTimes3);
        subplot(2,5,5);
        plot2dTrajectory(cloud,'x','y',lateTimes4);
        
        subplot(2,5,6);
        plot2dTrajectory(cloud,'z','x');
        subplot(2,5,7);
        plot2dTrajectory(cloud,'z','x',lateTimes);
        subplot(2,5,8);
        plot2dTrajectory(cloud,'z','x',lateTimes2);
        subplot(2,5,9);
        plot2dTrajectory(cloud,'z','x',lateTimes3);
        subplot(2,5,10);
        plot2dTrajectory(cloud,'z','x',lateTimes4);
    else
        if doeslateTimes3
            subplot(2,4,1);
            plot2dTrajectory(cloud,'x','y');
            subplot(2,4,2);
            plot2dTrajectory(cloud,'x','y',lateTimes);
            subplot(2,4,3);
            plot2dTrajectory(cloud,'x','y',lateTimes2);
            subplot(2,4,4);
            plot2dTrajectory(cloud,'x','y',lateTimes3);
            
            subplot(2,4,5);
            plot2dTrajectory(cloud,'z','x');
            subplot(2,4,6);
            plot2dTrajectory(cloud,'z','x',lateTimes);
            subplot(2,4,7);
            plot2dTrajectory(cloud,'z','x',lateTimes2);
            subplot(2,4,8);
            plot2dTrajectory(cloud,'z','x',lateTimes3);
        else
            if doeslateTimes2    
                subplot(2,3,1);
                plot2dTrajectory(cloud,'x','y');
                subplot(2,3,2);
                plot2dTrajectory(cloud,'x','y',lateTimes);
                subplot(2,3,3);
                plot2dTrajectory(cloud,'x','y',lateTimes2);
                
                subplot(2,3,4);
                plot2dTrajectory(cloud,'z','x');
                subplot(2,3,5);
                plot2dTrajectory(cloud,'z','x',lateTimes);
                subplot(2,3,6);
                plot2dTrajectory(cloud,'z','x',lateTimes2);
            else
                subplot(2,2,1);
                plot2dTrajectory(cloud,'x','y');
                subplot(2,2,2);
                plot2dTrajectory(cloud,'x','y',lateTimes);
                
                subplot(2,2,3);
                plot2dTrajectory(cloud,'z','x');
                subplot(2,2,4);
                plot2dTrajectory(cloud,'z','x',lateTimes);
            end
        end
    end
end
