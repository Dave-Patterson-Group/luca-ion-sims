function e = individualEnergy(y,cloud)
%returns just energy from trap itself and other ions, not applied fields
e = zeros(1,cloud.numIons);
potentialSet = cloud.potentialSet;
for i = 1:cloud.numIons  %each set is [x y z vx vy vz]
    mass = cloud.ions{i}.mass;
    
    vecPos = (i-1) * 6;
    potPos = (i-1) * 3;

    potx = 0.5 * y(vecPos+1) * y(vecPos+1) * potentialSet{potPos+1}.forceK;  %trap potential
    poty = 0.5 * y(vecPos+2) * y(vecPos+2) * potentialSet{potPos+2}.forceK;  %trap potential
    potz = 0.5 * y(vecPos+3) * y(vecPos+3) * potentialSet{potPos+3}.forceK;  %trap potential
    
    kinx = 0.5 * mass * y(vecPos+4) * y(vecPos+4);
    kiny = 0.5 * mass * y(vecPos+5) * y(vecPos+5);
    kinz = 0.5 * mass * y(vecPos+6) * y(vecPos+6);
    
    e(i) = potx + poty + potz + kinx + kiny + kinz;
    for j = [1:(i-1) (i+1):cloud.numIons]
        ivecPos = (i-1) * 6;
        jvecPos = (j-1) * 6;     
        iPos = y(ivecPos+(1:3)); 
        jPos = y(jvecPos+(1:3));
        U = couloumbPot(iPos,jPos);
        e(i) = e(i) + U;
    end
end

%This function keeps track of the individual energies of each ion, where
%all of the other ions are treated as an external potential. This means
%that the sum of the individual energies will be greater than the total
%energy. Keep this in mind when using this function!