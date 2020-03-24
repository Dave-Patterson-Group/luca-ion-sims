function plotFluorescence(cloud,timeSpan,region)
if nargin < 2
    timeSpan = [0 Inf];
end
if nargin < 3
    region = [-1e-3 1e-3];
end
figure('Position',[600   200   1000   600]);
c = makeConstants;
indivEnergyChanges = zeros(cloud.numIons,length(cloud.individualEnergies));
for i = 1:(length(cloud.individualEnergies)-1)
    indivEnergyChanges(:,i) = cloud.individualEnergies(1:cloud.numIons,i) - cloud.individualEnergies(1:cloud.numIons,i+1);
end
indivEnergyChanges(:,end) = indivEnergyChanges(:,end-1);
for i = 1:length(indivEnergyChanges)
    for j = 1:cloud.numIons
       if indivEnergyChanges(j,i) < 0
           indivEnergyChanges(j,i) = 0;
       end
    end
end
energyTrajectories = zeros(2*cloud.numIons,length(indivEnergyChanges));
energyTrajectories(1:cloud.numIons,:) = indivEnergyChanges;
for i = 1:cloud.numIons
    for j = 1:length(indivEnergyChanges)
        energyTrajectories(cloud.numIons + i,j) = cloud.trajectories(j,6 * (i-1) + 3);
    end
end
actualPhotons = zeros(1,length(indivEnergyChanges));
currentEnergy = 0;
for i = 1:length(indivEnergyChanges)
    for j = 1:cloud.numIons
         if region(1) < energyTrajectories(cloud.numIons + j,i) && region(2) > energyTrajectories(cloud.numIons + j,i)
             currentEnergy = currentEnergy + energyTrajectories(j,i);
         end
    end
    while currentEnergy > 0
        randEnergyChange = -1;
        while randEnergyChange < 0
            randAtomFreq = cauchy_dist(7.1116297286e14,2e7);
%             randLaserFreq = normrnd((7.1116297286e14 - 1e7),2.34e5);
            randEnergyChange = c.H * (randAtomFreq - (7.1116297286e14 - 1e7));
        end
        if currentEnergy > randEnergyChange
            currentEnergy = currentEnergy - randEnergyChange;
            actualPhotons(i) = actualPhotons(i) + 1;
        end
        if currentEnergy < randEnergyChange && currentEnergy > 0
            random = rand;
            if random <= (currentEnergy/randEnergyChange)
                actualPhotons(i) = actualPhotons(i) + 1;
            end
            currentEnergy = currentEnergy - randEnergyChange;
        end
    end
    currentEnergy = 0;
end
numBins = ceil(length(actualPhotons)/300);
fluorescence = zeros(1,numBins);
for i = 1:(numBins - 1)
    for j = 1:300
        fluorescence(i) = fluorescence(i) + actualPhotons(300*(i-1) + j);
    end
    fluorescence(i) = fluorescence(i) / 300;
end
for i = ((numBins-1)*300):length(actualPhotons)
    fluorescence(numBins) = fluorescence(numBins) + actualPhotons(i);
end
fluorescence(numBins) = fluorescence(numBins) / (length(actualPhotons) - ((numBins-1) * 300));
fluorescence = (fluorescence / (1.697688e-8));
fluorescence = round(0.003 * fluorescence);
newTimes = (1:numBins) * 300 * 1.697688e-8;
indexSpan = round(timeSpan / (300 * 1.697688e-8));
if indexSpan(1) == 0
    indexSpan(1) = 1;
end
if indexSpan(2) == Inf
    indexSpan(2) = numBins;
end
plot(newTimes(indexSpan(1):indexSpan(2)),fluorescence(indexSpan(1):indexSpan(2)));
xlabel('time');
ylabel('photons per second');
title(sprintf('Fluorescence from the region %g m < z < %g m',region(1),region(2)));
