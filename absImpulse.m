function pulse = absImpulse(dimension,timeSpan,absAmp,freq,phase)
if nargin < 4
    freq = 0;
end
if nargin < 5
    phase = 0;
end
pulse.pulseType = sprintf('E%c',dimension);
pulse.timeSpan = timeSpan;
pulse.phase = phase;
pulse.freq = freq;
pulse.amp = absAmp;
