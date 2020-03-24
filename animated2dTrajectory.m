function animated2dTrajectory(cloud,dim1,dim2,timeWindow,filename,narrowRegion,permTrails)
if nargin < 5
    filename = 'animatedTrajectories.gif';
end
if nargin < 6
    narrowRegion = 0;
end
if nargin < 7
    permTrails = 0;
end
fig = figure('Position',[100   100   1414   839],'Name',sprintf('%d atom cloud',cloud.numAtoms));
if nargin < 4
    timeWindow = [0 Inf];
    %titlestring = 'all times';
%else
%    titlestring = sprintf('%3.0f usec < t < %3.0f usec',timeWindow(1)*1e6,timeWindow(2)*1e6);
end
dim1Array = cell(1,cloud.numAtoms);
dim2Array = cell(1,cloud.numAtoms);
for i = 1:cloud.numAtoms
    dim1Array{i} = pullTrajectory(cloud,sprintf('%c%d',dim1,i),timeWindow);
    dim2Array{i} = pullTrajectory(cloud,sprintf('%c%d',dim2,i),timeWindow);
end

cmCoords1 = zeros(length(dim1Array{1}),1);
cmCoords2 = zeros(length(dim2Array{1}),1);
totalMass = 0;
for i = 1:cloud.numIons
    cmCoords1 = cmCoords1 + (88 * dim1Array{i});
    cmCoords2 = cmCoords2 + (88 * dim2Array{i});
    totalMass = totalMass + 88;
end
for j = (cloud.numIons + 1):(cloud.numIons + cloud.numMolecules)
    cmCoords1 = cmCoords1 + (89 * dim1Array{j});
    cmCoords2 = cmCoords2 + (89 * dim2Array{j});
    totalMass = totalMass + 89;
end
cmCoords1 = cmCoords1 / totalMass;
cmCoords2 = cmCoords2 / totalMass;
stepLength = 100;
for i = 1:(floor(length(dim1Array{1}) / stepLength))
    currentTime = round(((i * stepLength) * 1.697688e-8) * 1e5);
    currentTime = currentTime / 100;
    for j = 1:cloud.numAtoms
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
    for k = 1:cloud.numIons
        plot(dim1Array{k}(x:(i * stepLength)),dim2Array{k}(x:(i * stepLength)),dim1Array{k}((i * stepLength)),dim2Array{k}((i * stepLength)),'.b','MarkerSize',25)
        hold on
    end
    for k = (cloud.numIons + 1):(cloud.numIons + cloud.numMolecules)
        plot(dim1Array{k}(x:(i * stepLength)),dim2Array{k}(x:(i * stepLength)),'-r',dim1Array{k}((i * stepLength)),dim2Array{k}((i * stepLength)),'.r','MarkerSize',25)
        hold on
    end
    plot(cmCoords1(i * stepLength),cmCoords2(i * stepLength),'+','MarkerSize',15,'MarkerEdgeColor','k')
    hold on
    axis([-10e-4 10e-4 -10e-4 10e-4]) 
    forceSquare();
    xlabel(dim1);
    ylabel(dim2);
    if narrowRegion ~= 0
        line([narrowRegion(1) narrowRegion(1)],[-1 1],'Color','red');
        line([narrowRegion(2) narrowRegion(2)],[-1 1],'Color','red');
    end
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
