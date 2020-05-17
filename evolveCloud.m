function finalCloud = evolveCloud(ionCloud,pulseSet,t,zFreq)
%variable names h,k1,k2,k3,k4 picked to align with  https://en.wikipedia.org/wiki/Runge%E2%80%93Kutta_methods

%This is probably the most important and most-used function. given an
%initial cloud ionCloud, (generated by the initializeCloud) function), this
%function will evolve the cloud through time, from time 0 to time t (in
%seconds). It will apply the pulses contained within pulseSet at their
%designated times. The fourth argument, if included, while continuously,
%linearly changing the potential in the axial direction, from its original
%secular frequency for strontium ions specified in the potentialSet of the
%cloud (and in the potentialZ object for each ion), to the new secular
%frequency zFreq. At time 0, it will have its original frequency, and at
%time t, it will have zFreq. For most cases however, you don't need to
%change the axial secular frequency, so you don't need to include this
%fourth argument


h = ionCloud.dt;
numTimes = round(t / h);
fieldSet = compileFields(pulseSet,0:h:t);
const = makeConstants();
if nargin < 4
    dynamicZ = 0;
else
    dynamicZ = 1;
    zFreq0 = ionCloud.potentialSet{3}.freq;
end

trajectories = zeros(numTimes,length(ionCloud.vector));
t = fieldSet.times(1);
y = ionCloud.vector;

energies = zeros(1,numTimes);
individualEnergies = zeros(ionCloud.numIons,numTimes);
fracErrors = energies;
simTimes = energies;
energies(1) = energy(y,ionCloud);
initEnergies = individualEnergy(y,ionCloud);
for i = 1:ionCloud.numIons
    individualEnergies(i,1) = initEnergies(i);
end
simTimes(1) = t;
trajectories(1,:) = y;

h = h * 1.697688;
i = 2;

while t < fieldSet.times(end)
    [fracError] = rkError(y,t,h,ionCloud,fieldSet);
    [newy,newt,collided] = rkStep(y,t,h,ionCloud,fieldSet);  
    y = newy;
    t = newt;
    for j = 1:ionCloud.numIons
        ionCloud.numCollisions = ionCloud.numCollisions + collided(j);
    end
    if i > length(simTimes)
        trajectories = doubleLength(trajectories);
        energies = doubleLength(energies);
        individualEnergies = doubleLength(individualEnergies);
        simTimes = doubleLength(simTimes);
        fracErrors = doubleLength(fracErrors);
    end
    if mod(i,round(5000/1.697688)) == 1
        fprintf('time %1.3f/%1.3f ms, %d steps\n',t*1000,max(fieldSet.times)*1000,i);
    end
    
    trajectories(i,:) = y;
    energies(i) = energy(y,ionCloud);
    currentEnergies = individualEnergy(y,ionCloud);
    for j = 1:ionCloud.numIons
        individualEnergies(j,i) = currentEnergies(j);
    end
    simTimes(i) = t;
    fracErrors(i) = fracError;
    if dynamicZ == 1
        zAngFreq = 2*pi*(zFreq0 + (zFreq - zFreq0)*(t / fieldSet.times(end)) );
        zForceK = 88 * const.AMU * (zAngFreq)^2;
        for j = 1:ionCloud.numIons
            ionCloud.ions{j}.potentialz = updatePotentialZ(ionCloud.ions{j}.potentialz,zForceK);
            ionCloud.potentialSet{j*3} = updatePotentialZ(ionCloud.potentialSet{j*3},zForceK);
        end
    end
    if ionCloud.micro == 1
        for j = 1:ionCloud.numIons
            zForceK = ionCloud.potentialSet{((j-1)*3) + 3}.forceK; 
            ionCloud.potentialSet{((j-1)*3) + 1}.trueForceK = ionCloud.potentialSet{((j-1)*3) + 1}.Ak * cos(ionCloud.potentialSet{((j-1)*3) + 1}.RF * 2 * pi * t ) - (0.5 * zForceK); % updatePotentialXY(ionCloud.potentialSet{((j-1)*3) + 1},t,zForceK);
            ionCloud.potentialSet{((j-1)*3) + 2}.trueForceK = ionCloud.potentialSet{((j-1)*3) + 2}.Ak * cos(ionCloud.potentialSet{((j-1)*3) + 2}.RF * 2 * pi * t ) - (0.5 * zForceK); % updatePotentialXY(ionCloud.potentialSet{((j-1)*3) + 2},t,zForceK);
        end
    else
        for j = 1:ionCloud.numIons
            ionCloud.potentialSet{((j-1)*3) + 1}.trueForceK = ionCloud.potentialSet{((j-1)*3) + 1}.forceK;
            ionCloud.potentialSet{((j-1)*3) + 2}.trueForceK = ionCloud.potentialSet{((j-1)*3) + 2}.forceK;
        end
    end
    i = i+1;
end

finalCloud = ionCloud;

trajectories = trajectories(1:i-1,:);  %trim down to actual length
energies = energies(1:i-1);  %trim down to actual length
individualEnergies = individualEnergies(:,1:i-1);
fracErrors = fracErrors(1:i-1);
simTimes = simTimes(1:i-1);   


finalCloud.vector = y;
finalCloud.fracErrors = fracErrors;
finalCloud.energies = energies;
finalCloud.individualEnergies = individualEnergies;
finalCloud.times = simTimes;
finalCloud.trajectories = trajectories;
finalCloud.fieldSet = fieldSet;
finalCloud = updateIons(finalCloud);