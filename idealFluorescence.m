function fluor = idealFluorescence(ionCloud,timeSpan)
if nargin < 2
    timeSpan = [0 ionCloud.times(end)];
end
fieldSet = ionCloud.fieldSet;
const = makeConstants;

l1 = length(pullTrajectory(ionCloud,'vx1'));
l2 = length(fieldSet.coolingx);

fluorescence = zeros(1,min(l1,l2));


delta = fieldSet.cooling.delta; %  detuning: + => blue, - => red  
        
omega0 = 7.1116297286e14; % angular frequency of Sr transition
omega = omega0 + delta; % angular frequency of cooling laser
k = omega / const.C; % wavenumber of cooling laser
gamma = 2 * pi * 21e6;

for i = 1:ionCloud.numIons
    VX = pullTrajectory(ionCloud,sprintf('vx%d',i));
    VY = pullTrajectory(ionCloud,sprintf('vy%d',i));
    VZ = pullTrajectory(ionCloud,sprintf('vz%d',i));
    
    if length(fieldSet.coolingx) > length(VX)
        coolingx = fieldSet.coolingx(1:length(VX));
        coolingy = fieldSet.coolingy(1:length(VY));
        coolingz = fieldSet.coolingz(1:length(VZ));
        vx = VX;
        vy = VY;
        vz = VZ;
    elseif length(fieldSet.coolingx) < length(VX)
        vx = VX(1:length(fieldSet.coolingx));
        vy = VY(1:length(fieldSet.coolingy));
        vz = VZ(1:length(fieldSet.coolingz));
        coolingx = fieldSet.coolingx;
        coolingy = fieldSet.coolingy;
        coolingz = fieldSet.coolingz;
    else
        vx = VX;
        vy = VY;
        vz = VZ;
        coolingx = fieldSet.coolingx;
        coolingy = fieldSet.coolingy;
        coolingz = fieldSet.coolingz;
    end
    Rvx = zeros(1,length(vx));
    Rvy = zeros(1,length(vy));
    Rvz = zeros(1,length(vz));
    for j = 1:length(vx)
        Rvx(j) = ((gamma / 2) * coolingx(j)) / (1 + coolingx(j) + ((4 / (gamma^2)) * (delta - (k * vx(j) ) ).^2 ) );
        Rvy(j) = ((gamma / 2) * coolingy(j)) / (1 + coolingy(j) + ((4 / (gamma^2)) * (delta - (k * vy(j) ) ).^2 ) );
        Rvz(j) = ((gamma / 2) * coolingz(j)) / (1 + coolingz(j) + ((4 / (gamma^2)) * (delta - (k * vz(j) ) ).^2 ) );
    end
    fluorescence = fluorescence + Rvx + Rvy + Rvz;
end

fluorescence = round(0.003 * fluorescence);
indexSpan = round(timeSpan / (1.697688e-8));
if indexSpan(1) <= 0
    indexSpan(1) = 1;
end
if indexSpan(2) > length(fluorescence)
    indexSpan(2) = length(fluorescence);
end
fluor = fluorescence(indexSpan(1):indexSpan(2));
