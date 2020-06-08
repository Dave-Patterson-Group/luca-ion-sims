function wiggle = wiggleFromPulse(pulse,times)
switch pulse.pulseType
    case{'noisex','noisey','noisez'}
        dt = times(2) - times(1);
        wiggle = randn(size(times)) * pulse.amp / sqrt(dt);
        
    case{'slapx','slapy','slapz'}
        nArray = pulse.amp * cos(times * pulse.freq * 2 * pi); %ones(size(times));
        wiggle = nArray;
        
    case{'tweezer'}
        if pulse.freq == 0 || ~isfield(pulse,'freq')
            wiggle = ones(size(times));
        else
            wiggle = 0.5*square(times * 2 * pi * pulse.freq) + 0.5;
        end
        
    case{'chirpx','chirpy','chirpz'}
        intStart = round(pulse.timeSpan(1) / 5e-9);
        if intStart == 0
            intStart = 1;
        end
        intEnd = round(pulse.timeSpan(2) / 5e-9);
        wiggle = zeros(1,length(times));
        chirpTimes = times(intStart:intEnd) - times(intStart);
        wiggle(intStart:intEnd) = pulse.amp * chirp(chirpTimes,pulse.frequencySpan(1),chirpTimes(end),pulse.frequencySpan(2));
        
    otherwise
        wiggle = pulse.amp * cos((times * pulse.freq * 2 * pi) + pulse.phase);
    
        
end
wiggle(times < pulse.timeSpan(1)) = 0;
wiggle(times > pulse.timeSpan(2)) = 0;
