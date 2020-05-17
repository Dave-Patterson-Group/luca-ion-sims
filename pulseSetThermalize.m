function pulseSet = pulseSetThermalize(pulseSet,timeSpan,T,frictionAmp,delta)
if nargin < 3
    T = 0.05;
end
if nargin < 4
    frictionAmp = 1.5;     
end
if nargin < 5
    delta = -10e6;
end

noiseAmp = 4e-22* sqrt(T/10);

pulseSet{end+1} = pulseCooling('x',timeSpan,frictionAmp,delta);
pulseSet{end+1} = pulseCooling('y',timeSpan,frictionAmp,delta);
pulseSet{end+1} = pulseCooling('z',timeSpan,frictionAmp,delta);
pulseSet{end+1} = pulseEnoise('x',timeSpan,noiseAmp );
pulseSet{end+1} = pulseEnoise('y',timeSpan,noiseAmp);
pulseSet{end+1} = pulseEnoise('z',timeSpan,noiseAmp);

%This is pulseSet function just gives the cloud a little bit of random
%heating