function ydotVals = ydot(t,y,cloud,fieldSet,collided) %see https://en.wikipedia.org/wiki/Runge%E2%80%93Kutta_methods
%change this to reflect a potential? or simply hardwire (F = k_e q1 q2) / r^2) but ok for now
ydotVals = y * 0;
potentialSet = cloud.potentialSet;
ii = findIndex(fieldSet.times,t);
const = makeConstants();
for i = 1:cloud.numIons  %each set is [x y z vx vy vz]
    mass = cloud.ions{i}.mass;
    vecPos = (i-1) * 6;
    potPos = (i-1) * 3;
    forcex = -y(vecPos+1) * potentialSet{potPos+1}.trueForceK;  %trap potential
    forcey = -y(vecPos+2) * potentialSet{potPos+2}.trueForceK; 
    forcez = -y(vecPos+3) * potentialSet{potPos+3}.forceK;
    
    if fieldSet.tweezer(ii)
        spotSize = fieldSet.tweezerParameter.waist * (sqrt(1 + ((y(vecPos+1) - fieldSet.tweezerParameter.x) / fieldSet.tweezerParameter.xR)^2 ));
        expTerm = exp(-2*( ((y(vecPos+2) - fieldSet.tweezerParameter.y)^2) + ((y(vecPos+3) - fieldSet.tweezerParameter.z)^2) ) / (spotSize^2));
        
        forcex = forcex - ( (2 * fieldSet.tweezerParameter.depth * expTerm * (y(vecPos+1) - fieldSet.tweezerParameter.x) / (fieldSet.tweezerParameter.xR^2 * (1 + ((y(vecPos+1) - fieldSet.tweezerParameter.x) / fieldSet.tweezerParameter.xR)^2 )^2) ) - ( (4 * fieldSet.tweezerParameter.depth * expTerm * (y(vecPos+1) - fieldSet.tweezerParameter.x) * ((y(vecPos+2) - fieldSet.tweezerParameter.y)^2 + (y(vecPos+3) - fieldSet.tweezerParameter.z)^2)) / (fieldSet.tweezerParameter.xR^2 * fieldSet.tweezerParameter.waist^2 * (1 + ((y(vecPos+1) - fieldSet.tweezerParameter.x) / fieldSet.tweezerParameter.xR)^2 )^3) ) );
        forcey = forcey - (4 * fieldSet.tweezerParameter.depth * expTerm * (y(vecPos+2) - fieldSet.tweezerParameter.y) / (spotSize^2) );
        forcez = forcez - (4 * fieldSet.tweezerParameter.depth * expTerm * (y(vecPos+3) - fieldSet.tweezerParameter.z) / (spotSize^2) );
    end
    
    isSlappedX = 0;
    isSlappedY = 0;
    isSlappedZ = 0;
    for j = 1:length(fieldSet.slap.xAtoms)
        if i == fieldSet.slap.xAtoms(j)
            isSlappedX = 1;
        end
    end
    for j = 1:length(fieldSet.slap.yAtoms)
        if i == fieldSet.slap.yAtoms(j)
            isSlappedY = 1;
        end
    end
    for j = 1:length(fieldSet.slap.zAtoms)
        if i == fieldSet.slap.zAtoms(j)
            isSlappedZ = 1;
        end
    end
    
    forcex = forcex + (fieldSet.Ex(ii));  %drive field and noise
    forcex = forcex - (y(vecPos+1) * fieldSet.E2x(ii)); %squeezing or trap scaling
    if isSlappedX
        forcex = forcex + fieldSet.slapx(ii);
    end
    
    forcey = forcey + (fieldSet.Ey(ii));
    forcey = forcey - (y(vecPos+2) * fieldSet.E2y(ii)); %squeezing or trap scaling
    if isSlappedY
        forcey = forcey + fieldSet.slapy(ii);
    end
    
    forcez = forcez + (fieldSet.Ez(ii));
    forcez = forcez - (y(vecPos+3) * fieldSet.E2z(ii)); %squeezing or trap scaling
    if isSlappedZ
        forcez = forcez + fieldSet.slapz(ii);
    end
        
    if strcmp(cloud.ions{i}.type,'Sr')
        
        delta = fieldSet.cooling.delta; %  detuning: + => blue, - => red 
        
        omega0 = 7.1116297286e14; % angular frequency of Sr transition
        omega = omega0 + delta; % angular frequency of cooling laser
        k = omega / const.C; % wavenumber of cooling laser
        gamma = 2 * pi * 21e6; % linewidth
        
        % fieldSet.coolingx(ii) is the fraction I / I-sat
        % TODO: Maybe make the laser frequency a distribution instead of a
        % delta function?
        
        Rvx = ((gamma / 2) * fieldSet.coolingx(ii)) / (1 + fieldSet.coolingx(ii) + ((4 / (gamma^2)) * (delta - (k * y(vecPos+4) ) )^2 ) );
        Rvy = ((gamma / 2) * fieldSet.coolingy(ii)) / (1 + fieldSet.coolingy(ii) + ((4 / (gamma^2)) * (delta - (k * y(vecPos+5) ) )^2 ) );
        Rvz = ((gamma / 2) * fieldSet.coolingz(ii)) / (1 + fieldSet.coolingz(ii) + ((4 / (gamma^2)) * (delta - (k * y(vecPos+6) ) )^2 ) );
        
        theta = pi * rand();
        phi = 2 * pi * rand();
        
        forcex = forcex + (const.HBAR * k * Rvx) + (const.HBAR * k * sqrt(Rvx) * sin(theta) * cos(phi));
        forcey = forcey + (const.HBAR * k * Rvy) + (const.HBAR * k * sqrt(Rvy) * sin(theta) * sin(phi));
        forcez = forcez + (const.HBAR * k * Rvz) + (const.HBAR * k * sqrt(Rvz) * cos(theta));
        
        
    end
    
    
    if collided(i)
        const = makeConstants();
        mHe = 4.0026 * const.AMU;
        tempHe = cloud.bufferGasTemp; %Kelvin
        mAtom = cloud.atoms{i}.mass;
        
        vHeX = normrnd(-y(vecPos+4),((2 * const.BOLTZMANN * tempHe) / mHe)^(1/2));
        vHeY = normrnd(-y(vecPos+5),((2 * const.BOLTZMANN * tempHe) / mHe)^(1/2));
        vHeZ = normrnd(-y(vecPos+6),((2 * const.BOLTZMANN * tempHe) / mHe)^(1/2));
                
        vAtomNewX = (((2*mHe)/(mHe + mAtom))*vHeX) - (((mHe-mAtom)/(mHe+mAtom))*y(vecPos+4));
        vAtomNewY = (((2*mHe)/(mHe + mAtom))*vHeY) - (((mHe-mAtom)/(mHe+mAtom))*y(vecPos+5));
        vAtomNewZ = (((2*mHe)/(mHe + mAtom))*vHeZ) - (((mHe-mAtom)/(mHe+mAtom))*y(vecPos+6));
                
        deltaPx = mAtom*(vAtomNewX - y(vecPos+4));
        deltaPy = mAtom*(vAtomNewY - y(vecPos+5));
        deltaPz = mAtom*(vAtomNewZ - y(vecPos+6));
        deltaT = 1.697688e-8;
                
        forcex = forcex + (deltaPx / deltaT);
        forcey = forcey + (deltaPy / deltaT);
        forcez = forcez + (deltaPz / deltaT);
    end
    
    ydotVals(vecPos+1:vecPos+3) = y(vecPos+4:vecPos+6);
    ydotVals(vecPos+4) = forcex/mass; %dv_x/dt = f_x/m
    ydotVals(vecPos+5) = forcey/mass; %dv_x/dt = f_x/m
    ydotVals(vecPos+6) = forcez/mass; %dv_x/dt = f_x/m
end
%Coulomb interactions:
for i = 1:cloud.numIons
    for j = i+1:cloud.numIons
        ivecPos = (i-1) * 6;
        jvecPos = (j-1) * 6;
        iPos = y(ivecPos+(1:3));
        jPos = y(jvecPos+(1:3));
        F = couloumbForce(iPos,jPos);
        acci = F/cloud.ions{i}.mass;
        accj = -F/cloud.ions{j}.mass;
        ydotVals(ivecPos+(4:6)) = ydotVals(ivecPos+(4:6)) + acci;
        ydotVals(jvecPos+(4:6)) = ydotVals(jvecPos+(4:6)) + accj;
    end
end

