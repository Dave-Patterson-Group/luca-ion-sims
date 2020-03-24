function U = couloumbPot(iPos,jPos)
    Q = 1.602176462e-19; %from https://en.wikipedia.org/wiki/Elementary_charge
    Ke = 8.987551787e9; %from https://en.wikipedia.org/wiki/Coulomb%27s_constant
    
    delR = jPos - iPos;
    r = norm(delR);
    U = (Ke * Q * Q / r);
