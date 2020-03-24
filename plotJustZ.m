function p = plotJustZ(cloud,n,whichChannel)
if n > cloud.numAtoms
    return
end
if nargin < 3
    whichChannel = 'z';
end
times = cloud.times;
if n == 0
    zArray = cell(1,cloud.numAtoms);
    for i = 1:cloud.numAtoms
        zArray{i} = pullTrajectory(cloud,sprintf('%c%d','z',i));
    end
    cmCoordsz = zeros(length(times),1);
    totalMass = 0;
    for i = 1:cloud.numIons
        cmCoordsz = cmCoordsz + (88 * zArray{i});
        totalMass = totalMass + 88;
    end
    for i = (cloud.numIons + 1):(cloud.numIons + cloud.numMolecules)
        cmCoordsz = cmCoordsz + (89 * zArray{i});
        totalMass = totalMass + 89;
    end
    cmCoordsz = cmCoordsz / totalMass;
    hold all;
    plot(times,cmCoordsz,'k');
    legend('COMz');
else
    times = cloud.times;
    labelz = sprintf('%c%d',whichChannel,n);
    z = pullTrajectory(cloud,labelz);
    p = plot(times,z,'k:');
    a = legend;
    oldLegend = a.String;
    oldLegend{end} = labelz;
    legend(oldLegend);
end
