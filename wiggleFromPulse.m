function wiggle = wiggleFromPulse(pulse,times)
switch pulse.pulseType
    case{'noisex','noisey','noisez'}
        dt = times(2) - times(1);
        wiggle = randn(size(times)) * pulse.amp / sqrt(dt);
        
    case{'slapx','slapy','slapz'}
        nArray = pulse.amp * cos(times * pulse.freq * 2 * pi); %ones(size(times));
        wiggle = nArray;
        
    case{'pulseLaser','CWLaser'}
        wiggle = ones(size(times));

    case{'opticalx','opticaly','opticalz'}
        dt = times(2) - times(1);
        t = times(end) - times(1);
        numFlips = round(t * pulse.freq);
        avgFlipInterval = ceil(length(times) / numFlips);
        noiseArray = randn(size(times)) * pulse.amp / sqrt(dt);
        wiggle = noiseArray;
        flipInterval = zeros(1,(numFlips + 1));
        for l = 1:(numFlips + 1)
            flipInterval(l) = ceil(avgFlipInterval + (50 * randn));
        end
        j = 1;
        k = 1;
        for i = 2:length(times)
            if mod(k,flipInterval(j)) ~= 0
                wiggle(i) = wiggle(i-1);
                k = k+1;
            else
                j = j+1;
                k = 1;
            end
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
