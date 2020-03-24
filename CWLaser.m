function pulse = CWLaser(timespan,power,lambda,waist,polarizability,xCenterCW,yCenterCW,zCenterCW)
if nargin < 6
    xCenterCW = 0;
    yCenterCW = 0;
    zCenterCW = 0;
end
pulse.pulseType = sprintf('CWLaser');
pulse.timeSpan = timespan;
pulse.lambdaCW = lambda;
pulse.waistCW = waist;
intensity = power * 2 / (pi * waist * waist);
pulse.EzeroCW = sqrt(intensity / (3e8 * 8.8e-12)); %3e8 = c, 8.8 e-12 = epsilon0
pulse.xRCW = (pi * waist * waist) / (lambda);
pulse.polarizabilityCW = polarizability;
pulse.xCenterCW = xCenterCW;
pulse.yCenterCW = yCenterCW;
pulse.zCenterCW = zCenterCW;
