function pot = potFromAtom(atom,dimension)
switch dimension
    case 'x'
        pot = atom.potentialx;
    case 'y'
        pot = atom.potentialy;
    case 'z'
        pot = atom.z;
end
