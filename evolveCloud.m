function finalCloud = evolveCloud(ionCloud,pulseSet,t,tStartChange,newPot1,tSecondChange,newPot2)
if nargin < 4
    doesChange = 0;
    doesChangeTwice = 0;
end
if nargin == 5 
    doesChange = 1;
    doesChangeTwice = 0;
end
if nargin > 5
    doesChange = 1;
    doesChangeTwice = 1;
end
%no dynamic timing yet
%variable names h,k1,k2,k3,k4 picked to align with  https://en.wikipedia.org/wiki/Runge%E2%80%93Kutta_methods
changeTime = 1.0e-4;
changeIndex = round(changeTime / 1.697688e-8);
h = ionCloud.dt;
numTimes = round(t / h);
fieldSet = compileFields(pulseSet,0:h:t);
zPotentialTime.zPot = [];
zPotentialTime.zTimes = [];
switch doesChange
    case 1
        zPotentialTime.zChanges = 1;
        iStartChange = round(tStartChange / 1.697688e-8);
    case 0
        zPotentialTime.zChanges = 0;
end
if doesChangeTwice
    iSecondChange = round(tSecondChange / 1.697688e-8);
else
    iSecondChange = 0;
end
trajectories = zeros(numTimes,length(ionCloud.vector));
t = fieldSet.times(1);
y = ionCloud.vector;

finalCloud = ionCloud;
energies = zeros(1,numTimes);
individualEnergies = zeros(ionCloud.numAtoms,numTimes);
fracErrors = energies;
simTimes = energies;
energies(1) = energy(y,ionCloud);
initEnergies = individualEnergy(y,ionCloud);
for i = 1:ionCloud.numAtoms
    individualEnergies(i,1) = initEnergies(i);
end
simTimes(1) = t;
trajectories(1,:) = y;

h = h * 1.697688;
i = 2;
if ionCloud.atoms{1}.friction == 1
    originalPot = ionCloud.potentialSet{3}.freq;
else
    originalPot = (ionCloud.potentialSet{3}.freq / 0.912);
end
if doesChange
    atomPotStep = ((newPot1 - originalPot) / changeIndex);
    moleculePotStep = (((newPot1*0.912) - (originalPot*0.912)) / changeIndex);
end
while t < fieldSet.times(end)
    if doesChange
        if i == iStartChange
            fprintf('About to start changing trap\n');
        end
        if (iStartChange < i) && (i < iStartChange + changeIndex + 1)
            k = i - iStartChange;
            for j = 1:ionCloud.numAtoms
                if ionCloud.atoms{j}.friction == 1
                    newPot = defaultPotentialZ(originalPot + (atomPotStep * k),ionCloud.atoms{j}.mass);
                else
                    newPot = defaultPotentialZ((originalPot * 0.912) + (moleculePotStep * k),ionCloud.atoms{j}.mass);  
                end
                ionCloud.potentialSet{(j*3)} = newPot;
            end
        end
        if i == iStartChange + changeIndex + 1
            fprintf('Finished changing trap\n');
        end
        
        if (i == iSecondChange) && doesChangeTwice
            fprintf('About to start changing trap\n');
            if ionCloud.atoms{1}.friction == 1
                updatedPot = ionCloud.potentialSet{3}.freq;
            else
                updatedPot = (ionCloud.potentialSet{3}.freq / 0.912);
            end
        end
        if (iSecondChange < i) && (i < iSecondChange + changeIndex + 1) && doesChangeTwice
            k = i - iSecondChange;
            atomPotStep2 = ((newPot2 - updatedPot) / changeIndex);
            moleculePotStep2 = (((newPot2*0.912) - (updatedPot*0.912)) / changeIndex);
            for j = 1:ionCloud.numAtoms
                if ionCloud.atoms{j}.friction == 1
                    newPot = defaultPotentialZ(updatedPot + (atomPotStep2 * k),ionCloud.atoms{j}.mass);
                else
                    newPot = defaultPotentialZ((updatedPot * 0.912) + (moleculePotStep2 * k),ionCloud.atoms{j}.mass);  
                end
                ionCloud.potentialSet{(j*3)} = newPot;
            end
        end
        if (i == iSecondChange + changeIndex + 1) && doesChangeTwice
            fprintf('Finished changing trap\n');
            if ionCloud.atoms{1}.friction == 1
                updatedPot = ionCloud.potentialSet{3}.freq;
            else
                updatedPot = (ionCloud.potentialSet{3}.freq / 0.912);
            end
        end
    end
    currentPot = ionCloud.potentialSet{3}.freq;
    [fracError] = rkError(y,t,h,ionCloud,fieldSet);
    [newy,newt,collided] = rkStep(y,t,h,ionCloud,fieldSet,0);  
    y = newy;
    t = newt;
    for j = 1:ionCloud.numAtoms
        finalCloud.numCollisions = finalCloud.numCollisions + collided(j);
    end
    if i > length(simTimes)
        trajectories = doubleLength(trajectories);
        energies = doubleLength(energies);
        individualEnergies = doubleLength(individualEnergies);
        simTimes = doubleLength(simTimes);
        fracErrors = doubleLength(fracErrors);
    end
    if mod(i,5000) == 0
        fprintf('time %f/%f, %d steps\n',t,max(fieldSet.times),i);
    end
    
    trajectories(i,:) = y;
    energies(i) = energy(y,ionCloud);
    currentEnergies = individualEnergy(y,ionCloud);
    for j = 1:ionCloud.numAtoms
        individualEnergies(j,i) = currentEnergies(j);
    end
    simTimes(i) = t;
    fracErrors(i) = fracError;
    zPotentialTime.zPot(i-1) = currentPot;
    for j = 1:ionCloud.numAtoms
        zForceK = ionCloud.potentialSet{((j-1)*3) + 3}.forceK;
        Vx = ionCloud.potentialSet{((j-1)*3) + 1}.voltage;
        Vy = ionCloud.potentialSet{((j-1)*3) + 2}.voltage;
        ionCloud.potentialSet{((j-1)*3) + 1} = defaultPotential(Vx,t,ionCloud.atoms{j}.mass,'x',zForceK);
        ionCloud.potentialSet{((j-1)*3) + 2} = defaultPotential(Vy,t,ionCloud.atoms{j}.mass,'y',zForceK);
    end
    i = i+1;
end
for i = 1:(length(zPotentialTime.zPot))
    zPotentialTime.zTimes(end + 1) = (i / length(zPotentialTime.zPot)) * t;
end

trajectories = trajectories(1:i-1,:);  %trim down to actual length
energies = energies(1:i-1);  %trim down to actual length
individualEnergies = individualEnergies(:,1:i-1);
fracErrors = fracErrors(1:i-1);
simTimes = simTimes(1:i-1);   %these horrible 8 lines preallocate arrays a bit..
1;

finalCloud.vector = y;
finalCloud.fracErrors = fracErrors;
finalCloud.energies = energies;
finalCloud.individualEnergies = individualEnergies;
finalCloud.times = simTimes;
finalCloud.trajectories = trajectories;
finalCloud.fieldSet = fieldSet;
finalCloud = updateAtoms(finalCloud);
finalCloud.zPotentialTime = zPotentialTime;
