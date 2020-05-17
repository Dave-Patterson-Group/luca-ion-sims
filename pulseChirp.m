function pulse = pulseChirp(dimension,timeSpan,frequencySpan,absAmp)
pulse.pulseType = sprintf('chirp%c',dimension);
pulse.timeSpan = timeSpan;
pulse.frequencySpan = frequencySpan;
pulse.amp = absAmp;

%This type of pulse applies a chirped E field to the ions. Parameters:
%dimension is either 'x', 'y', or 'z'
%timeSpan is an array, telling when to start and stop the chirp: 
% [startTime endTime] (ex. [0 1e-3])
%frequencySpan is an array, with the initial and final frequencies of the
% chirp: [initialFrequency finalFrequency] (ex. [50e3 100e3])
%absAmp is the amplitude of the E-field in Newtons/Coulomb (ex. 1e-20)
