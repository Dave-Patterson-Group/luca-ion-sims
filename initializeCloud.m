function cloud = initializeCloud(numAtoms,numFriction,cloudType,xPot,yPot,zPot)
if nargin < 2
    numFriction = numAtoms;
    cloudType = 'tightZ';
end
if numFriction == numAtoms
    isMixed = 'atoms';
else
    if numFriction ~= numAtoms && numFriction ~= 0
        isMixed = 'mixed';
    end
    if numFriction == 0
        isMixed = 'mlcls';
    end
end
atoms = cell(1,numAtoms);
if strcmp(isMixed,'atoms')
    for i = 1:numAtoms
        switch cloudType
            case 'tightZ'
                atoms{i} = initializeTightAtom(1);
            case 'looseZ'
                atoms{i} = initializeLooseAtom(1);
            case 'customZ'
                atoms{i} = initializeCustomAtom(1,xPot,yPot,zPot);
        end
    end     
end

if strcmp(isMixed,'mlcls')
    for i = 1:numAtoms
        switch cloudType
            case 'tightZ'
                atoms{i} = initializeTightAtom(2);
            case 'looseZ'
                atoms{i} = initializeLooseAtom(2);
            case 'customZ'
                atoms{i} = initializeCustomAtom(2,xPot,yPot,zPot);
        end
    end     
end

if strcmp(isMixed,'mixed')
    for i = 1:numFriction
        switch cloudType
            case 'tightZ'
                atoms{i} = initializeTightAtom(1);
            case 'looseZ'
                atoms{i} = initializeLooseAtom(1);
            case 'customZ'
                atoms{i} = initializeCustomAtom(1,xPot,yPot,zPot);
        end
    end
    for i = (numFriction+1):numAtoms
      switch cloudType
           case 'tightZ'
               atoms{i} = initializeTightAtom(2);
           case 'looseZ'
               atoms{i} = initializeLooseAtom(2);
           case 'customZ'
               atoms{i} = initializeCustomAtom(2,xPot,yPot,zPot);
      end
    end      
end

cloud.numAtoms = numAtoms;
cloud.numIons = numFriction;
cloud.numMolecules = numAtoms - numFriction;
cloud.atoms = atoms;
cloud.dt = 1e-8;
cloud.interacting = 1;
cloud = updateCloud(cloud);
cloud = tickleCloud(cloud);
cloud.isMixed = isMixed;
cloud.bufferGasBool = false;
cloud.bufferGasTime = [0 0];
cloud.bufferGasDensity = 0;
cloud.bufferGasTemp = 0;
cloud.numCollisions = 0;
