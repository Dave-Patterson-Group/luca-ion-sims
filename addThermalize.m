function pulseSet = addThermalize(pulseSet,timeSpan,T,frictionMult,frictionAmp,delta)
if nargin < 4
    frictionMult = 1;
end
if nargin < 5
    frictionAmp = 1;     
end
if nargin < 6
    delta = 10e6;
end

noiseAmp = 4e-22* sqrt(T/10);
    pulseSet{end+1} = absFrictionPulse('x',(frictionMult*timeSpan),frictionAmp,delta);
    pulseSet{end+1} = absFrictionPulse('y',(frictionMult*timeSpan),frictionAmp,delta);
    pulseSet{end+1} = absFrictionPulse('z',(frictionMult*timeSpan),frictionAmp,delta);
    pulseSet{end+1} = absNoisePulse('x',timeSpan,noiseAmp );
    pulseSet{end+1} = absNoisePulse('y',timeSpan,noiseAmp);
    pulseSet{end+1} = absNoisePulse('z',timeSpan,noiseAmp);
