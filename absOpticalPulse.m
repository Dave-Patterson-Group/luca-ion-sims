function pulse = absOpticalPulse(dimension,timeSpan,freq)
pulse.pulseType = sprintf('optical%c',dimension);
pulse.timeSpan = timeSpan;
pulse.phase = 0;
pulse.freq = freq;
pulse.amp = 8e-22* sqrt(.005);
