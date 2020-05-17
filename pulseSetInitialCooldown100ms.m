function pulseSet = pulseSetInitialCooldown100ms(pulseSet)
if nargin < 1
    pulseSet = {};
end
pulseSet = pulseSetCooling(pulseSet,[0e-3 10e-3],1.5,-100e6);
pulseSet = pulseSetCooling(pulseSet,[10e-3 20e-3],1.5,-90e6);
pulseSet = pulseSetCooling(pulseSet,[20e-3 30e-3],1.5,-80e6);
pulseSet = pulseSetCooling(pulseSet,[30e-3 40e-3],1.5,-70e6);
pulseSet = pulseSetCooling(pulseSet,[40e-3 50e-3],1.5,-60e6);
pulseSet = pulseSetCooling(pulseSet,[50e-3 60e-3],1.5,-50e6);
pulseSet = pulseSetCooling(pulseSet,[58e-3 70e-3],1.5,-40e6);
pulseSet = pulseSetCooling(pulseSet,[70e-3 80e-3],1.5,-30e6);
pulseSet = pulseSetCooling(pulseSet,[80e-3 90e-3],1.5,-20e6);
pulseSet = pulseSetCooling(pulseSet,[90e-3 100e-3],1.5,-10e6);

%This is a pre-made pulseSet which is good for cooling down initially hot
%clouds. It lasts for 100e-3 seconds, and starts with a high red-detuning,
%and slowly turns it down as the ions cool,