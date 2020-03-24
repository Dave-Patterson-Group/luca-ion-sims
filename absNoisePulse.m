function pulse = absNoisePulse(dimension,timeSpan,absAmp)
pulse.pulseType = sprintf('noise%c',dimension);
pulse.timeSpan = timeSpan;
pulse.phase = 0;
pulse.freq = 0;
pulse.amp = absAmp;
