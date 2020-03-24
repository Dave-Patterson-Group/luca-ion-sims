function pulseSet = slapShot(pulseSet,timeSpan,xAmp,yAmp,zAmp,atoms)
pulseSet{end+1} = slap('x',timeSpan,xAmp,atoms);
pulseSet{end+1} = slap('y',timeSpan,yAmp,atoms);
pulseSet{end+1} = slap('z',timeSpan,zAmp,atoms);
