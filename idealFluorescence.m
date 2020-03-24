function fluor = idealFluorescence(finalCloud,timeSpan)
if nargin < 2
    timeSpan = [0 Inf];
end
fieldSet = finalCloud.fieldSet;
const = makeConstants;

l1 = length(pullTrajectory(finalCloud,'vx1'));
l2 = length(fieldSet.frictionx);

fluorescence = zeros(1,min(l1,l2));


delta = fieldSet.delta; %  detuning: + => blue, - => red   CHANGE THIS ONE TO ALTER LASER
        
omega0 = 7.1116297286e14; % angular frequency of Sr transition
omega = omega0 + delta; % angular frequency of cooling laser
k = omega / const.C; % wavenumber of cooling laser
gamma = 2 * pi * 21e6;

for i = 1:finalCloud.numIons
    VX = pullTrajectory(finalCloud,sprintf('vx%d',i));
    VY = pullTrajectory(finalCloud,sprintf('vy%d',i));
    VZ = pullTrajectory(finalCloud,sprintf('vz%d',i));
    
    if length(fieldSet.frictionx) > length(VX)
        frictionx = fieldSet.frictionx(1:length(VX));
        frictiony = fieldSet.frictiony(1:length(VY));
        frictionz = fieldSet.frictionz(1:length(VZ));
        vx = VX;
        vy = VY;
        vz = VZ;
    elseif length(fieldSet.frictionx) < length(VX)
        vx = VX(1:length(fieldSet.frictionx));
        vy = VY(1:length(fieldSet.frictiony));
        vz = VZ(1:length(fieldSet.frictionz));
        frictionx = fieldSet.frictionx;
        frictiony = fieldSet.frictiony;
        frictionz = fieldSet.frictionz;
    else
        vx = VX;
        vy = VY;
        vz = VZ;
        frictionx = fieldSet.frictionx;
        frictiony = fieldSet.frictiony;
        frictionz = fieldSet.frictionz;
    end
    Rvx = zeros(1,length(vx));
    Rvy = zeros(1,length(vy));
    Rvz = zeros(1,length(vz));
    for j = 1:length(vx)
        Rvx(j) = ((gamma / 2) * frictionx(j)) / (1 + frictionx(j) + ((4 / (gamma^2)) * (delta - (k * vx(j) ) ).^2 ) );
        Rvy(j) = ((gamma / 2) * frictiony(j)) / (1 + frictiony(j) + ((4 / (gamma^2)) * (delta - (k * vy(j) ) ).^2 ) );
        Rvz(j) = ((gamma / 2) * frictionz(j)) / (1 + frictionz(j) + ((4 / (gamma^2)) * (delta - (k * vz(j) ) ).^2 ) );
    end
    fluorescence = fluorescence + Rvx + Rvy + Rvz;
end

fluorescence = round(0.003 * fluorescence);
indexSpan = round(timeSpan / (1.697688e-8));
if indexSpan(1) == 0
    indexSpan(1) = 1;
end
if indexSpan(2) == inf
    indexSpan(2) = length(fluorescence);
end
fluor = fluorescence(indexSpan(1):indexSpan(2));
