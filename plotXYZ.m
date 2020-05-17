function plotXYZ(cloud,n)
%This function plots the x, y, and z trajectories of the nth ion as
%functions of time. Setting n = 0 instead plots the x,y,z motion
%of the center of mass of the cloud.

if n > cloud.numIons
    return
end
darkMass = cloud.darkMass;
times = cloud.times;
if n == 0
    xArray = cell(1,cloud.numIons);
    yArray = cell(1,cloud.numIons);
    zArray = cell(1,cloud.numIons);
    for i = 1:cloud.numIons
        xArray{i} = pullTrajectory(cloud,sprintf('%c%d','x',i));
        yArray{i} = pullTrajectory(cloud,sprintf('%c%d','y',i));
        zArray{i} = pullTrajectory(cloud,sprintf('%c%d','z',i));
    end
    cmCoordsx = zeros(length(times),1);
    cmCoordsy = zeros(length(times),1);
    cmCoordsz = zeros(length(times),1);
    totalMass = 0;
    for i = 1:cloud.numSr
        cmCoordsx = cmCoordsx + (88 * xArray{i});
        cmCoordsy = cmCoordsy + (88 * yArray{i});
        cmCoordsz = cmCoordsz + (88 * zArray{i});
        totalMass = totalMass + 88;
    end
    for i = (cloud.numSr + 1):(cloud.numSr + cloud.numDark)
        cmCoordsx = cmCoordsx + (darkMass * xArray{i});
        cmCoordsy = cmCoordsy + (darkMass * yArray{i});
        cmCoordsz = cmCoordsz + (darkMass * zArray{i});
        totalMass = totalMass + darkMass;
    end
    cmCoordsx = cmCoordsx / totalMass;
    cmCoordsy = cmCoordsy / totalMass;
    cmCoordsz = cmCoordsz / totalMass;
    hold all;
    plot(times,cmCoordsx,'r',times,cmCoordsy,'b',times,cmCoordsz,'k');
    legend('COMx','COMy','COMz');
else
    times = cloud.times;
    labelx = sprintf('x%d',n);
    labely = sprintf('y%d',n);
    labelz = sprintf('z%d',n);
    x = pullTrajectory(cloud,labelx);
    y = pullTrajectory(cloud,labely);
    z = pullTrajectory(cloud,labelz);
    plot(times,x,'r');
    hold all;
    plot(times,y,'b');
    plot(times,z,'k');
    legend(labelx,labely,labelz);
end
