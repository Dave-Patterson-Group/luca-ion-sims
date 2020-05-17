function fieldSet = compileFields(pulseSet,times)
times = doubleTimes(times);
fieldSet = blankSet(length(times));
fieldSet.slap.xAtoms = [];
fieldSet.slap.yAtoms = [];
fieldSet.slap.zAtoms = [];

fieldSet.tweezerParameter.waist = 1;
fieldSet.tweezerParameter.xR = 1;
fieldSet.tweezerParameter.x = 0;
fieldSet.tweezerParameter.y = 0;
fieldSet.tweezerParameter.z = 0;

fieldSet.chirpx = zeros(1,length(times));
fieldSet.chirpy = zeros(1,length(times));
fieldSet.chirpz = zeros(1,length(times));

fieldSet.cooling.delta = 0;

for i = 1:length(pulseSet)
    thisPulse = pulseSet{i};
    fieldSet.(thisPulse.pulseType) = fieldSet.(thisPulse.pulseType) + wiggleFromPulse(thisPulse,times);
    switch thisPulse.pulseType
        case {'coolingx','coolingy','coolingz'}
            fieldSet.cooling.delta = thisPulse.delta;
        case 'tweezer'
            fieldSet.tweezerParameter.waist = thisPulse.waist;
            fieldSet.tweezerParameter.xR = thisPulse.xR;
            fieldSet.tweezerParameter.depth = thisPulse.depth;
            fieldSet.tweezerParameter.x = thisPulse.x;
            fieldSet.tweezerParameter.y = thisPulse.y;
            fieldSet.tweezerParameter.z = thisPulse.z;
            fprintf('Depth of Optical Tweezers: %4.5f K \n',(fieldSet.tweezerParameter.depth / 1.38e-23));
        case 'slapx'
            fieldSet.slap.xAtoms = thisPulse.atoms;
        case 'slapy'
            fieldSet.slap.yAtoms = thisPulse.atoms;
        case 'slapz'
            fieldSet.slap.zAtoms = thisPulse.atoms;
    end
end
fieldSet.Ex = fieldSet.Ex + fieldSet.noisex + fieldSet.chirpx;
fieldSet.Ey = fieldSet.Ey + fieldSet.noisey + fieldSet.chirpy;
fieldSet.Ez = fieldSet.Ez + fieldSet.noisez + fieldSet.chirpz;
fieldSet.times = times;
