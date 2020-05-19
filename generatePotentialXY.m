function pot = generatePotentialXY(xyPot,m,zForceK,axis,RF)
if nargin < 5
    RF = 2e6;
end
switch axis
    case 'x'
        B = 1;
    case 'y'
        B = -1;
end
pot.RF = RF;
pot.freq = xyPot;
pot.angFreq = xyPot * 2 * pi;
pot.mass = m;
pot.forceK = pot.mass * pot.angFreq^2;
pot.Ak = B * (RF * 2 * pi) * m * sqrt(2*(pot.angFreq)^2 + (zForceK / m));
pot.trueForceK = pot.Ak - (0.5 * zForceK);
pot.axis = axis;
pot.phase = 0;
