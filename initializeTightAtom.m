function atom = initializeTightAtom(type)
if nargin == 0
    type = 'Sr';
end
switch type
    case 'Sr'
        type = 1;
    case 'SrO'
        type = 2;
end
modType = mod(type,2);
atom.constants = makeConstants();
atom.xyz = [0 0 0];
atom.vxvyvz = [0 0 0];
atom.type = type;
switch modType
    case 1
        atom.mass = 88 * atom.constants.AMU;
        atom.charge = 1 * atom.constants.E;
        atom.potentialz = defaultPotentialZ(5e4,atom.mass);
        atom.potentialx = defaultPotential(100,0,atom.mass,'x',atom.potentialz.forceK);
        atom.potentialy = defaultPotential(100.1,0,atom.mass,'y',atom.potentialz.forceK);
        atom.friction = 1;
    case 0
        atom.mass = 89 * atom.constants.AMU; %CHANGED THIS TO TEST TICKLESCAN OF DARK ION MASS
        atom.charge = 1 * atom.constants.E;
        atom.potentialz = defaultPotentialZ(4.972e4,atom.mass);
        atom.potentialx = defaultPotential(100,0,atom.mass,'x',atom.potentialz.forceK);
        atom.potentialy = defaultPotential(100.1,0,atom.mass,'y',atom.potentialz.forceK);
        atom.friction = 0;
end
