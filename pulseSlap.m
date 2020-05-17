function pulse = pulseSlap(dimension,timeSpan,absAmp,atoms,freq)
if nargin < 5
    freq = 0;
end
pulse.pulseType = sprintf('slap%c',dimension);
pulse.timeSpan = timeSpan;
pulse.amp = absAmp;
pulse.atoms = atoms;
pulse.freq = freq;

%This pulse doesn't have much of a physical meaning, I was using it to
%model hitting the individual ions with a deep optical potential before I
%added an accurate optical tweezers pulse. Basically just slaps whichever
%ions you specify in a direction specified by dimension. Parameters:
%dimension is either 'x','y', or 'z'
%timeSpan is an array, telling when to turn on and off the slap: 
% [startTime endTime] (ex. [0 1e-3])
%absAmp is the amplitude of the force in Newtons (ex. 1e-20)
%atoms is an array of integers specifiying which ions get slapped. The
% numbering of ions works as follows. If you specify n strontium ions and m
% dark ions, ions 1 through n are strontium, and ions n+1 through n+m are
% darks. For example, if you have three ions in a chain, 1 Sr and 2 dark, and you
% only wanted to slap the dark ions, then you would input atoms = [2 3]
%freq is the frequency of the slap if you want it to oscillate. Usually
% this is just zero.