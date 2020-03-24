function plotXYZ(cloud,n)
if n > cloud.numAtoms
    return
end
times = cloud.times;
if n == 0
    xArray = cell(1,cloud.numAtoms);
    yArray = cell(1,cloud.numAtoms);
    zArray = cell(1,cloud.numAtoms);
    for i = 1:cloud.numAtoms
        xArray{i} = pullTrajectory(cloud,sprintf('%c%d','x',i));
        yArray{i} = pullTrajectory(cloud,sprintf('%c%d','y',i));
        zArray{i} = pullTrajectory(cloud,sprintf('%c%d','z',i));
    end
    cmCoordsx = zeros(length(times),1);
    cmCoordsy = zeros(length(times),1);
    cmCoordsz = zeros(length(times),1);
    totalMass = 0;
    for i = 1:cloud.numIons
        cmCoordsx = cmCoordsx + (88 * xArray{i});
        cmCoordsy = cmCoordsy + (88 * yArray{i});
        cmCoordsz = cmCoordsz + (88 * zArray{i});
        totalMass = totalMass + 88;
    end
    for i = (cloud.numIons + 1):(cloud.numIons + cloud.numMolecules)
        cmCoordsx = cmCoordsx + (89 * xArray{i});
        cmCoordsy = cmCoordsy + (89 * yArray{i});
        cmCoordsz = cmCoordsz + (89 * zArray{i});
        totalMass = totalMass + 89;
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
