function pot = generatePotentialZ(f,m)
pot.freq = f;  %in Hz
pot.angFreq = pot.freq * 2 * pi;
pot.mass = m;
pot.forceK = pot.mass * pot.angFreq^2;
pot.axis = 'z';
