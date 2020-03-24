function order = varOrder(n)
    order = cell(1,6*n);
    for i = 1:n
        order{6*(i-1) + 1} = sprintf('x%d',i);
        order{6*(i-1) + 2} = sprintf('y%d',i);
        order{6*(i-1) + 3} = sprintf('z%d',i);
        order{6*(i-1) + 4} = sprintf('vx%d',i);
        order{6*(i-1) + 5} = sprintf('vy%d',i);
        order{6*(i-1) + 6} = sprintf('vz%d',i);
    end
