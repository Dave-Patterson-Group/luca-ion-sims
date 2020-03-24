function pulse = absFrictionPulse(dimension,timeSpan,absAmp,delta)
if nargin < 4
   delta = -10e6;
end
pulse.pulseType = sprintf('friction%c',dimension);
pulse.timeSpan = timeSpan;
pulse.phase = 0;
pulse.freq = 0;
pulse.amp = absAmp;
pulse.delta = delta;
