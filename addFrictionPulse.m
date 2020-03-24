function pulseSet = addFrictionPulse(pulseSet,timeSpan,absAmp,delta)
if nargin < 3
    absAmp = 1;
end
if nargin < 4
    delta = -10e6;
end
pulseSet{end+1} = absFrictionPulse('x',timeSpan,absAmp,delta);
pulseSet{end+1} = absFrictionPulse('y',timeSpan,absAmp,delta);
pulseSet{end+1} = absFrictionPulse('z',timeSpan,absAmp,delta);
