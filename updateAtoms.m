function cloud = updateAtoms(cloud)
    for i = 1:cloud.numAtoms
        vpoint = (6*(i-1));
    end
    cloud.atoms{i}.xyz = (cloud.vector(vpoint+1:vpoint+3));
    cloud.atoms{i}.vxvyvz = (cloud.vector(vpoint+4:vpoint+6));
