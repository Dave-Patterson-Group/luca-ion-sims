function pulseSet = pulseSetCooling(pulseSet,timeSpan,absAmp,delta)
if nargin < 3
    absAmp = 1;
end
if nargin < 4
    delta = -10e6;
end
pulseSet{end+1} = pulseCooling('x',timeSpan,absAmp,delta);
pulseSet{end+1} = pulseCooling('y',timeSpan,absAmp,delta);
pulseSet{end+1} = pulseCooling('z',timeSpan,absAmp,delta);

%This pulseSet function adds cooling pulses of the same amplitude and
%detuning to all 3 directions. It's just a shortcut so you don't have to
%type each individual pulse. Oftentimes this will be the first thing you
%start the pulseSet with, so you'll input pulseSet = {};