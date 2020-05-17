function pulse = pulseTweezer(timespan,xCenter,yCenter,zCenter,depth)
if nargin < 2
    xCenter = 0;
    yCenter = 0;
    zCenter = 0;
end
if nargin < 5
    depth = 2.369e-25;
end
pulse.pulseType = sprintf('tweezer');
pulse.timeSpan = timespan;
pulse.waist = 3e-6;
pulse.xR = 53e-6;
pulse.depth = depth;
pulse.x = xCenter;
pulse.y = yCenter;
pulse.z = zCenter;

%This pulse models a potential due to optical tweezers being shined in from the x-axis.
% The beam waist and Rayleigh length are set to the parameters Zeyun gave me,
% as is the default setting for the potential depth. Parameters:
%timeSpan is an array, telling when to turn on and off the tweezers: 
% [startTime endTime] (ex. [0 1e-3])
%xCenter, yCenter, and zCenter are floats, specifying coordinates of the 
% focal point of the tweezers. Generally you'll want to keep xCenter at 0,
% unless you don't want the focal point to be in the same plane as the trap
% center. Units are in meters. (ex. 0,1e-6,2e6)
%depth is a float, it specifies the potential depth in Joules. If not
% included when calling the function, it defaults to the depth given to me
% by Zeyun's calculations. (ex. 5e-25)