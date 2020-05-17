function pulse = pulseEnoise(dimension,timeSpan,absAmp)
pulse.pulseType = sprintf('noise%c',dimension);
pulse.timeSpan = timeSpan;
pulse.phase = 0;
pulse.freq = 0;
pulse.amp = absAmp;

%This pulse applies a random "noisy" E-field. Parameters:
%dimension is either 'x','y', or 'z'
%timeSpan is an array, telling when to turn on and off the E-field: 
% [startTime endTime] (ex. [0 1e-3])
%absAmp is the amplitude of the E-field in Newtons/Coulomb (ex. 1e-20)