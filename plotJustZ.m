function p = plotJustZ(cloud,n)
%This function plots the motion in just the axial (z) direction of a single
%ion, the nth ion in cloud.ions. Setting n = 0 instead plots the z-motion
%of the center of mass of the cloud.

if n > cloud.numIons
    return
end
times = cloud.times;
if n == 0
    zArray = cell(1,cloud.numIons);
    for i = 1:cloud.numIons
        zArray{i} = pullTrajectory(cloud,sprintf('%c%d','z',i));
    end
    cmCoordsz = zeros(length(times),1);
    totalMass = 0;
    for i = 1:cloud.numSr
        cmCoordsz = cmCoordsz + (88 * zArray{i});
        totalMass = totalMass + 88;
    end
    for i = (cloud.numSr + 1):(cloud.numSr + cloud.numDark)
        cmCoordsz = cmCoordsz + (cloud.darkMass * zArray{i});
        totalMass = totalMass + cloud.darkMass;
    end
    cmCoordsz = cmCoordsz / totalMass;
    hold all;
    plot(times,cmCoordsz,'k');
    legend('COMz');
else
    times = cloud.times;
    labelz = sprintf('%c%d','z',n);
    z = pullTrajectory(cloud,labelz);
    p = plot(times,z,'k:');
    a = legend;
    oldLegend = a.String;
    oldLegend{end} = labelz;
    legend(oldLegend);
end
