function fieldSet = compileFields(pulseSet,times)
times = doubleTimes(times);
fieldSet = blankSet(length(times));
fieldSet.xAtoms = [];
fieldSet.yAtoms = [];
fieldSet.zAtoms = [];

fieldSet.waistPulse = 1;
fieldSet.EzeroPulse = 0;
fieldSet.xRPulse = 1;
fieldSet.polarizabilityPulse = 0;
fieldSet.OPxCenterPulse = 0;
fieldSet.OPyCenterPulse = 0;
fieldSet.OPzCenterPulse = 0;

fieldSet.waistCW = 1;
fieldSet.EzeroCW = 0;
fieldSet.xRCW = 1;
fieldSet.polarizabilityCW = 0;
fieldSet.OPxCenterCW = 0;
fieldSet.OPyCenterCW = 0;
fieldSet.OPzCenterCW = 0;

fieldSet.chirpx = zeros(1,length(times));
fieldSet.chirpy = zeros(1,length(times));
fieldSet.chirpz = zeros(1,length(times));

fieldSet.delta = 0;

for i = 1:length(pulseSet)
    thisPulse = pulseSet{i};
    fieldSet.(thisPulse.pulseType) = fieldSet.(thisPulse.pulseType) + wiggleFromPulse(thisPulse,times);
    if (strcmp(thisPulse.pulseType,'frictionx')) || (strcmp(thisPulse.pulseType,'frictiony')) || (strcmp(thisPulse.pulseType,'frictionz'))
        fieldSet.delta = thisPulse.delta;
    end
    if strcmp(thisPulse.pulseType,'pulseLaser')
        fieldSet.waistPulse = thisPulse.waistPulse;
        fieldSet.EzeroPulse = thisPulse.EzeroPulse;
        fieldSet.xRPulse = thisPulse.xRPulse;
        fieldSet.polarizabilityPulse = thisPulse.polarizabilityPulse;
        fieldSet.OPxCenterPulse = thisPulse.xCenterPulse;
        fieldSet.OPyCenterPulse = thisPulse.yCenterPulse;
        fieldSet.OPzCenterPulse = thisPulse.zCenterPulse;
        OpticalDepthPulse = fieldSet.polarizabilityPulse * (fieldSet.EzeroPulse * fieldSet.EzeroPulse) / 1.38e-23;
        if OpticalDepthPulse ~= 0
            fprintf('Depth of Pulse Laser Potential: %4.2f K \n',OpticalDepthPulse); %Fix this to handle multiple OPs
        end
    end
    if strcmp(thisPulse.pulseType,'CWLaser')
        fieldSet.waistCW = thisPulse.waistCW;
        fieldSet.EzeroCW = thisPulse.EzeroCW;
        fieldSet.xRCW = thisPulse.xRCW;
        fieldSet.polarizabilityCW = thisPulse.polarizabilityCW;
        fieldSet.OPxCenterCW = thisPulse.xCenterCW;
        fieldSet.OPyCenterCW = thisPulse.yCenterCW;
        fieldSet.OPzCenterCW = thisPulse.zCenterCW;
        OpticalDepthCW = fieldSet.polarizabilityCW * (fieldSet.EzeroCW * fieldSet.EzeroCW) / 1.38e-23;
        if OpticalDepthCW ~= 0
            fprintf('Depth of CW Laser Potential: %4.5f K \n',OpticalDepthCW); %Fix this to handle multiple OPs
        end
    end
    if strcmp(thisPulse.pulseType,'slapx')
        fieldSet.xAtoms = thisPulse.atoms;
    end
    if strcmp(thisPulse.pulseType,'slapy')
        fieldSet.yAtoms = thisPulse.atoms;
    end
    if strcmp(thisPulse.pulseType,'slapz')
        fieldSet.zAtoms = thisPulse.atoms;
    end
end
fieldSet.Ex = fieldSet.Ex + fieldSet.noisex + fieldSet.chirpx;
fieldSet.Ey = fieldSet.Ey + fieldSet.noisey + fieldSet.chirpy;
fieldSet.Ez = fieldSet.Ez + fieldSet.noisez + fieldSet.chirpz;

fieldSet.times = times;
