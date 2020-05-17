function pulse = pulseEfield(dimension,timeSpan,absAmp,freq,phase)
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

%This pulse applies either a constant or sinusoidal E-field to the ions:
% E(t) = absAmp*cos(2pi*freq*t + phase). Parameters:
%dimension is either 'x','y', or 'z'
%timeSpan is an array, telling when to turn on and off the E-field: 
% [startTime endTime] (ex. [0 1e-3])
%absAmp is the amplitude of the E-field in Newtons/Coulomb (ex. 1e-20)
%freq is the frequency of oscillation. freq = 0 means constant E-field
%phase is the initial phase of oscillation. This is rarely nonzero.