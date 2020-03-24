function pot = defaultPotential(V,t,m,axis,zForceK,RF)
if nargin < 6
    RF = 2e6;
end
RF = RF * 2 * pi;
c = makeConstants();
q = 1 * c.E;
pot.angFreq = sqrt((q * V / ( (2^(1/2)) * m * RF * (2.8956e-3)^2))^2 - (0.5 * zForceK / m));
pot.freq = pot.angFreq / (2 * pi);  %in Hz
pot.mass = m;
pot.forceK = pot.mass * pot.angFreq^2;
% try to just input the radial average secular frequency, then move to RF
% from there, don't bother with calculating it from voltage
if axis == 'x'
    pot.trueForceK = (q * V * cos(RF * t) / ((2.8956e-3)^2)) - (0.5 * zForceK);
end
if axis == 'y'
    pot.trueForceK = (-1 * q * V * cos(RF * t) / ((2.8956e-3)^2)) - (0.5 * zForceK);
end
pot.axis = axis;
pot.voltage = V;
pot.descriptor = sprintf('%s potential, f = %3.1f MHz',pot.axis,pot.freq/1e6);