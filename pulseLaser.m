function pulse = pulseLaser(time,pulseEnergy,lambda,waist,polarizability,xCenterPulse,yCenterPulse,zCenterPulse)
if nargin < 6
    xCenterPulse = 0;
    yCenterPulse = 0;
    zCenterPulse = 0;
end
pulse.pulseType = sprintf('pulseLaser');
pulse.timeSpan = [(time) (time + 5e-9)];
pulse.lambdaPulse = lambda;
pulse.waistPulse = waist;
intensity = (pulseEnergy / 5e-9) * 2 / (pi * waist * waist);
pulse.EzeroPulse = sqrt(intensity / (3e8 * 8.8e-12)); %3e8 = c, 8.8 e-12 = epsilon0
pulse.xRPulse = (pi * waist * waist) / (lambda);
pulse.polarizabilityPulse = polarizability;
pulse.xCenterPulse = xCenterPulse;
pulse.yCenterPulse = yCenterPulse;
pulse.zCenterPulse = zCenterPulse;
