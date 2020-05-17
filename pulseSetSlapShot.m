function pulseSet = pulseSetSlapShot(pulseSet,timeSpan,xAmp,yAmp,zAmp,atoms)
pulseSet{end+1} = pulseSlap('x',timeSpan,xAmp,atoms);
pulseSet{end+1} = pulseSlap('y',timeSpan,yAmp,atoms);
pulseSet{end+1} = pulseSlap('z',timeSpan,zAmp,atoms);

%This is just a shortcut for inputting a slap pulse in each direction at
%once, instead of having to type them out individually