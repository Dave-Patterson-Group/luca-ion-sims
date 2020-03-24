function pulseSet = makePulseSet(cloud)
%first make a pulseList describing all the fields.  This can be compiled
%into actual fields
    pulseSet = {};
    pulseSet = addThermalize(pulseSet,[0 4e-4],0.1);
    pulseSet{end+1} = squeezePulse(cloud.atoms{1},'x',0,[5e-4 1.6e-3],20);
