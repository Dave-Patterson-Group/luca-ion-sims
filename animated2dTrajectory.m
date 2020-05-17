function animated2dTrajectory(cloud,dim1,dim2,timeWindow,filename,permTrails)
%This is probably my favorite function, as it produces an animated GIF of
%the motion of the ions. The required arguments are cloud, dim1, and dim2:
%cloud is the ion cloud whose trajectories you want to see
%dim1 and dim2 are either 'x', 'y', or 'z'. dim1 is the dimension that will
% be plotted along the horizontal axis, and dim2 is the dimension that will
% be plotted along the vertical axis
%timeWindow is a time span array, specifying which times you want to see
% the trajectory of (in seconds): [startTime endTime] (ex. [0 1e-3])
%filename is a string,, it's the name that the GIF file will be saved as.
% It MUST end with .gif (ex. 'someCoolTrajectories.gif') if you don't
% specify a filename, it will save as 'animatedTrajectories.gif', but
% beware: if you then run this function again with a different trajectory,
% it will overwrite the original file! So I recommend always inputting a
% filename.
%permTrails is either 1 or 0. 0 by default, the ions will be plotted as
% little dots with a short trail behind each one, showing the trajectory it
% just followed. If permTrails is set to 1, then this trail won't erase
% itself, it will stay there permanently, showing the entire trajectory.
% Sometimes this is useful, but often it's just messy, so it's off by
% default, and generally you don't need to include this argument
%Here's an example of a valid function call:
% animated2dTrajectory(exampleCloud,'z','x',[5e-3 6e-3],'exampleTrajectory.gif')

if nargin < 5
    filename = 'animatedTrajectories.gif';
end
if nargin < 6
    permTrails = 0;
end
fig = figure('Position',[100   100   700   700],'Name',sprintf('%d atom cloud',cloud.numIons));
if nargin < 4
    timeWindow = [0 Inf];
    %titlestring = 'all times';
%else
%    titlestring = sprintf('%3.0f usec < t < %3.0f usec',timeWindow(1)*1e6,timeWindow(2)*1e6);
end
dim1Array = cell(1,cloud.numIons);
dim2Array = cell(1,cloud.numIons);
for i = 1:cloud.numIons
    dim1Array{i} = pullTrajectory(cloud,sprintf('%c%d',dim1,i),timeWindow);
    dim2Array{i} = pullTrajectory(cloud,sprintf('%c%d',dim2,i),timeWindow);
end

cmCoords1 = zeros(length(dim1Array{1}),1);
cmCoords2 = zeros(length(dim2Array{1}),1);
totalMass = 0;
for i = 1:cloud.numSr
    cmCoords1 = cmCoords1 + (88 * dim1Array{i});
    cmCoords2 = cmCoords2 + (88 * dim2Array{i});
    totalMass = totalMass + 88;
end
for j = (cloud.numSr + 1):(cloud.numSr + cloud.numDark)
    cmCoords1 = cmCoords1 + (cloud.darkMass * dim1Array{j});
    cmCoords2 = cmCoords2 + (cloud.darkMass * dim2Array{j});
    totalMass = totalMass + cloud.darkMass;
end
cmCoords1 = cmCoords1 / totalMass;
cmCoords2 = cmCoords2 / totalMass;
stepLength = 100;
for i = 1:(floor(length(dim1Array{1}) / stepLength))
    currentTime = round(((i * stepLength) * 1.697688e-8) * 1e5);
    currentTime = currentTime / 100;
    for j = 1:cloud.numIons
        if permTrails
            x = 1;
        else
            if i < 2
                x = 1;
            else
                x = (i - 1) * stepLength;
            end
        end
    end
    for k = 1:cloud.numSr
        plot(dim1Array{k}(x:(i * stepLength)),dim2Array{k}(x:(i * stepLength)),dim1Array{k}((i * stepLength)),dim2Array{k}((i * stepLength)),'.b','MarkerSize',25)
        hold on
    end
    for k = (cloud.numSr + 1):(cloud.numSr + cloud.numDark)
        plot(dim1Array{k}(x:(i * stepLength)),dim2Array{k}(x:(i * stepLength)),'-r',dim1Array{k}((i * stepLength)),dim2Array{k}((i * stepLength)),'.r','MarkerSize',25)
        hold on
    end
    plot(cmCoords1(i * stepLength),cmCoords2(i * stepLength),'+','MarkerSize',15,'MarkerEdgeColor','k')
    hold on
    axis([-1e-4 1e-4 -1e-4 1e-4]) 
    forceSquare();
    xlabel(dim1);
    ylabel(dim2);
    trueCurrentTime = (timeWindow(1)*1e3) + currentTime;
    title("t = " + trueCurrentTime + " milliseconds");
    drawnow
    frame = getframe(fig);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if i == 1
        imwrite(imind,cm,filename,'gif','DelayTime',0.05,'Loopcount',inf); 
    else 
        imwrite(imind,cm,filename,'gif','DelayTime',0.05,'WriteMode','append'); 
    end 
    hold off
end
