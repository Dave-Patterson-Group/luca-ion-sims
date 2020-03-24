function pulse = slap(dimension,timeSpan,absAmp,atoms,freq)
if nargin < 5
    freq = 0;
end
pulse.pulseType = sprintf('slap%c',dimension);
pulse.timeSpan = timeSpan;
pulse.amp = absAmp;
pulse.atoms = atoms;
pulse.freq = freq;
