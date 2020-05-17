function pulse = pulseCooling(dimension,timeSpan,absAmp,delta)
if nargin < 3
    absAmp = 1.5;
end
if nargin < 4
   delta = -10e6;
end
pulse.pulseType = sprintf('cooling%c',dimension);
pulse.timeSpan = timeSpan;
pulse.phase = 0;
pulse.freq = 0;
pulse.amp = absAmp;
pulse.delta = delta;

%This type of pulse applies doppler cooling to the system. Only strontium
% ions will feel it. Parameters:
%dimension is either 'x','y', or 'z'
%timeSpan is an array, telling when to turn on and off the laser cooling: 
% [startTime endTime] (ex. [0 1e-3])
%absAmp is intensity of the laser, as a multiple of the saturation
% intensity. absAmp = 0.5 is half the saturation intensity, absAmp = 2 is
% twice the saturation intensity, etc.
%delta is the detuning of the laser. Negative is red-detuned, positive is
% blue. Default is 10 MHz red. The hotter the ions are, the more
% red-detuned it needs to be to efficiently cool.