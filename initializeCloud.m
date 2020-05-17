%Start here! This will probably be the first function in any script you write
%It generates a cloud with numSr strontium ions and numDark dark ions
%xPot,yPot,and zPot are the secular frequencies of the strontium ions
%darkMass is the mass of the dark ions/molecules, default is 89 amu (SrH)
%micro is a bool, 1 means micromotion is turned on, 0 means it's off

function cloud = initializeCloud(numSr,numDark,xPot,yPot,zPot,darkMass,micro)
if nargin < 3   
    xPot = 100e3; % Secular frequencies of Sr ions in x,y,z.
    yPot = 101e3; % if micromotion is on (micro = 1), 
    zPot = 50e3;  % then x and y are only approximate
end
if nargin < 6
    darkMass = 89; %default dark ion mass in AMU
end
if nargin < 7
    micro = 1; %micromotion on by default
end

ions = cell(1,numSr + numDark); %ions is a list of 
for i = 1:numSr
    ions{i} = initializeSrIon(xPot,yPot,zPot);
end
for i = (numSr+1):(numSr+numDark)
    ions{i} = initializeDarkIon(xPot,yPot,zPot,darkMass);
end
cloud.numIons = numSr + numDark;
cloud.numSr = numSr;
cloud.numDark = numDark;
cloud.ions = ions;
cloud.dt = 1e-8;
cloud = updateCloud(cloud);
cloud = tickleCloud(cloud);
cloud.micro = micro;
cloud.darkMass = darkMass;

cloud.bufferGasBool = false;
cloud.bufferGasTime = [0 0];
cloud.bufferGasDensity = 0;     % Come back and adjust this later
cloud.bufferGasTemp = 0;
cloud.numCollisions = 0;

