function atom = initializeCustomAtom(type,xPot,yPot,zPot)
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
        atom.potentialz = defaultPotentialZ(zPot,atom.mass);
        atom.potentialx = defaultPotential(xPot,0,atom.mass,'x',atom.potentialz.forceK);
        atom.potentialy = defaultPotential(yPot,0,atom.mass,'y',atom.potentialz.forceK);
        atom.friction = 1;
    case 0
        atom.mass = 89 * atom.constants.AMU;
        atom.charge = 1 * atom.constants.E;
        atom.potentialz = defaultPotentialZ((zPot * 0.994366),atom.mass); %    NEED TO CHANGE THIS TO VARY MASS: ZPOT * SQRT(88 / MASS OF MOLECULE)
        atom.potentialx = defaultPotential(xPot,0,atom.mass,'x',atom.potentialz.forceK);
        atom.potentialy = defaultPotential(yPot,0,atom.mass,'y',atom.potentialz.forceK);
        atom.friction = 0;
end
