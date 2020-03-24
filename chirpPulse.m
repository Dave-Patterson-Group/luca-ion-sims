function pulse = chirpPulse(dimension,timeSpan,frequencySpan,absAmp)
pulse.pulseType = sprintf('chirp%c',dimension);
pulse.timeSpan = timeSpan;
pulse.frequencySpan = frequencySpan;
pulse.amp = absAmp;
