function pot = updatePotentialZ(pot,zForceK)
pot.forceK = zForceK;
pot.angFreq = sqrt(pot.forceK / pot.mass);
pot.freq = pot.angFreq / (2*pi);  %in Hz
