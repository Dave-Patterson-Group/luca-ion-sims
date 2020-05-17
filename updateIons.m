function cloud = updateIons(cloud)
    for i = 1:cloud.numIons
        vpoint = (6*(i-1));
    end
    cloud.ions{i}.xyz = (cloud.vector(vpoint+1:vpoint+3));
    cloud.ions{i}.vxvyvz = (cloud.vector(vpoint+4:vpoint+6));
