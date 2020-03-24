function pot = defaultPotentialZ(f,m)
pot.freq = f;  %in Hz
pot.angFreq = pot.freq * 2 * pi;
pot.mass = m;
pot.forceK = pot.mass * pot.angFreq^2;
pot.axis = 'z';
pot.descriptor = sprintf('%s potential, f = %3.1f MHz',pot.axis,pot.freq/1e6);
%function H = defaultHamiltonian()